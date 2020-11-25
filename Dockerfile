FROM centos:7

ENV http_proxy=http://proxy-chain.intel.com:911
ENV https_proxy=http://proxy-chain.intel.com:912

#RUN yum install -y centos-release-scl && yum update -y && yum install -y \
RUN yum install -d6 -y epel-release centos-release-scl && yum update -d6 -y && yum install -d6 -y \
            cmake3 \
            gcc gcc-c++ gdb valgrind \
            devtoolset-8-gcc* \
            make \
            python3 \
            unzip \
            wget \
            which \
            && yum clean all

#SHELL [ "/usr/bin/scl", "enable", "devtoolset-8" ]



# Set up bazel 
ENV BAZEL_VERSION 2.0.0
WORKDIR /bazel
RUN curl -fSsL -O https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VERSION/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    chmod +x bazel-*.sh && \
    ./bazel-$BAZEL_VERSION-installer-linux-x86_64.sh

# install openVINO
#ARG DLDT_PACKAGE_URL=http://nncv-nas-01.ccr.corp.intel.com/ovino-pkg/packages/nightly/2020WW42.2/master/121/irc/linux/l_openvino_toolkit_p_2021.1.121.tgz
ARG DLDT_PACKAGE_URL=http://nncv-nas-01.ccr.corp.intel.com/ovino-pkg/packages/nightly/2020WW47.4/releases/2021/2/150/irc/linux/l_openvino_toolkit_p_2021.2.150.tgz
RUN wget $DLDT_PACKAGE_URL && \
    tar -zxf l_openvino_toolkit*.tgz && \
    cd l_openvino_toolkit* && \
    sed -i 's/decline/accept/g' silent.cfg && \
    ./install.sh -s silent.cfg --ignore-signature && \
     ln -s /opt/intel/openvino_2021 /opt/intel/openvino

ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/intel/openvino/deployment_tools/inference_engine/lib/intel64/:/opt/intel/openvino/deployment_tools/ngraph/lib/:/opt/intel/openvino/inference_engine/external/tbb/lib/

WORKDIR /ovms_plugin_ov
COPY ovms_plugin_ov/ /ovms_plugin_ov/
ENV TBB_DIR=/opt/intel/openvino/inference_engine/external/tbb/cmake/
RUN source /opt/intel/openvino/bin/setupvars.sh && cmake3 . && make

WORKDIR /main
COPY main/ /main/
COPY model/ /model/

SHELL [ "/usr/bin/scl", "enable", "devtoolset-8" ]
ENV CC=/opt/rh/devtoolset-8/root/bin/gcc
ENV CXX=/opt/rh/devtoolset-8/root/bin/g++

RUN cmake3 . && make

# run
RUN /main/m

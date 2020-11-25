#include <string>
#include <iostream>
#include <memory>

#define USE_OV 1

#if USE_OV
    #include <inference_engine.hpp>
#endif

#include "ovms_plugin_ov.h"

OVMS_EXPORT int ovms_plugin_ov_read_network(const char* file_path) {
    std::cout << "ovms_plugin_ov_read_network " << file_path << std::endl;
#if USE_OV
    InferenceEngine::Core engine;
    InferenceEngine::CNNNetwork network;
    network = engine.ReadNetwork("/model/squeezenet1.1.xml");
    engine.LoadNetwork(network, "CPU");
#endif
    std::cout << "ovms_plugin_ov_read_network - SUCCESS" << std::endl;
    return 0;
}

void not_even_called_segfaullt() {
#if USE_OV
    InferenceEngine::DataPtr dptr = std::make_shared<InferenceEngine::Data>("", InferenceEngine::Precision::FP32);
#endif
}

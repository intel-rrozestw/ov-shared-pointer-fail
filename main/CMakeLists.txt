cmake_minimum_required(VERSION 2.8)
project(m)

add_executable(${PROJECT_NAME} main.cc)

set (CMAKE_CXX_FLAGS "-std=c++17  -static-libgcc -static-libstdc++ -fvisibility=hidden  -Wl,--exclude-libs,ALL -Wl,-z,relro -Wl,-z,now -fstack-protector -Wl,-z,noexecstack ${CMAKE_CXX_FLAGS}")
add_compile_options ( -Wall -fvisibility=hidden  )

#find_package(InferenceEngine REQUIRED)

target_include_directories(
    ${PROJECT_NAME}
    PRIVATE
     ${PROJECT_SOURCE_DIR}/../ovms_plugin_ov/include
#    ${InferenceEngine_DIR}/../include
)

#target_link_libraries(${PROJECT_NAME} PRIVATE ${InferenceEngine_LIBRARIES})

target_link_libraries(${PROJECT_NAME} PRIVATE
     ${PROJECT_SOURCE_DIR}/../ovms_plugin_ov/libovms_plugin_ov.so
)

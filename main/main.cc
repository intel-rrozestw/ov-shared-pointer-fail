#include <string>
#include <iostream>
#include <memory>
#include "ovms_plugin_ov.h"


int main(int argc, char** argv) {
    ovms_plugin_ov_read_network("/model/squeezenet1.1.xml");
/*
    InferenceEngine::Core [Aengine;
    InferenceEngine::CNNNetwork network;
    network = engine.ReadNetwork("/model/squeezenet1.1.xml");
    engine.LoadNetwork(network, "CPU");
*/
    std::cout << "SUCCESS" << std::endl;
  
    return 0;
}

#include <string>
#include <iostream>
#include <memory>
#include <inference_engine.hpp>

void not_even_called_segfaullt() {
    InferenceEngine::DataPtr dptr = std::make_shared<InferenceEngine::Data>("", InferenceEngine::Precision::FP32);
}

int main(int argc, char** argv) {
    InferenceEngine::Core engine;
    InferenceEngine::CNNNetwork network;
    network = engine.ReadNetwork("/model/squeezenet1.1.xml");
    engine.LoadNetwork(network, "CPU");

    std::cout << "SUCCESS" << std::endl;
  
    return 0;
}

cmake_minimum_required(VERSION 2.8)
project(m)

add_executable(${PROJECT_NAME} main.cc)

set (CMAKE_CXX_FLAGS "-std=c++11 ${CMAKE_CXX_FLAGS}")

find_package(InferenceEngine REQUIRED)

target_include_directories(
    ${PROJECT_NAME}
    PRIVATE
    ${InferenceEngine_DIR}/../include
)

target_link_libraries(${PROJECT_NAME} PRIVATE ${InferenceEngine_LIBRARIES})

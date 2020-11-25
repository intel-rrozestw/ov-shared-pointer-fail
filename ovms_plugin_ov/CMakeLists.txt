cmake_minimum_required(VERSION 2.8)
project(ovms_plugin_ov)

add_library(${PROJECT_NAME} SHARED ovms_plugin_ov_main.cc)

set(CMAKE_INSTALL_RPATH "$ORIGIN/")
add_compile_options ( -Wall -fvisibility=hidden  )
add_link_options ( -static-libgcc -static-libstdc++ -fvisibility=hidden  -Wl,--exclude-libs,ALL -Wl,-z,relro -Wl,-z,now -fstack-protector -Wl,-z,noexecstack)


target_include_directories( ${PROJECT_NAME}
    PUBLIC ${PROJECT_SOURCE_DIR}/include
)
file(GLOB HEADERS include/${PROJECT_NAME}/*.h include/${PROJECT_NAME}/*.hpp)
set_target_properties(${PROJECT_NAME} PROPERTIES PUBLIC_HEADER "${HEADERS}")


set (CMAKE_CXX_FLAGS "-std=c++11 ${CMAKE_CXX_FLAGS}")

find_package(InferenceEngine REQUIRED)

target_include_directories(
    ${PROJECT_NAME}
    PRIVATE
    ${InferenceEngine_DIR}/../include
)

target_link_libraries(${PROJECT_NAME} PRIVATE ${InferenceEngine_LIBRARIES})

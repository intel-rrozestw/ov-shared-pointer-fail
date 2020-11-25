#pragma once

#define OVMS_EXPORT extern "C" __attribute__((visibility("default")))

OVMS_EXPORT int ovms_plugin_ov_read_network(const char* file_path);

#!/usr/bin/env python3
import ctypes
d = ctypes.CDLL("./libovms_plugin_ov.so")
d.ovms_plugin_ov_read_network("/tmp/ojej.sh")

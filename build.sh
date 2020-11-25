#!/bin/bash
docker build . --build-arg REBUILD_FROM_HERE=$(date +%Y%m%d-%H%M%S) -t ov-fail:rr

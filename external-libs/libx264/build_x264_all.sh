#!/bin/sh

#chmod a+x x264_*.sh

# Build arm v6
./build_x264_arm.sh
# Build arm-v7a
./build_x264_arm_v7a.sh
# Build arm64 v8a
./build_x264_arm64_v8a.sh
# Build x86
./build_x264_x86.sh
# Build x86_64
./build_x264_x86_64.sh

#cd d
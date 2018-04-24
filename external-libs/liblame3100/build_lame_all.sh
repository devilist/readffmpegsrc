#!/bin/sh

#chmod a+x build_lame_*.sh

# Build arm v6
./build_lame_arm.sh
# Build arm-v7a
./build_lame_arm_v7a.sh
# Build arm64 v8a
./build_lame_arm64_v8a.sh
# Build x86
./build_lame_x86.sh
# Build x86_64
./build_lame_x86_64.sh

#cd C:/Cplusplus/ffmpeg/ffmpeg342_android/external-libs/liblame3100
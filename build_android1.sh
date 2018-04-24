#!/bin/sh
export TMPDIR=$(pwd)/build_temp #设置编译中临时文件目录

#NDK路径
export NDK=C:/Android/SDK/ndk-bundle

#编译针对的平台，这里选择最低支持android-14, arm架构，
#生成的so库是放在libs/armeabi文件夹下的，
#若针对x86架构，要选择arch-x86
export PLATFORM=$NDK/platforms/android-14/arch-arm/

# 工具链的路径，arm-linux-androideabi-4.9 与PLATFORM对应
export TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/windows-x86_64


function build_one {
./configure \
--target-os=linux \
--prefix=$PREFIX \
--arch=arm \
--disable-static \
--disable-doc \
--disable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-ffserver \
--disable-avdevice \
--disable-symver \
--disable-asm \
--disable-stripping \
--disable-debug \
--enable-shared \
--enable-cross-compile \
--enable-runtime-cpudetect \
--enable-gpl \
--enable-small \
--sysroot=$PLATFORM \
--cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
--extra-cflags="-Os -fpic $ADDI_CFLAGS" \
--extra-ldflags="$ADDI_LDFLAGS" \
$ADDITIONAL_CONFIGURE_FLAG

make clean
make
make install
}

CPU=armv7-a
ADDI_CFLAGS="-marm"
PREFIX=$(pwd)/build_output/android/$CPU
ADDITIONAL_CONFIGURE_FLAG=
build_one

#--extra-libs=-lgcc \
#-I$NDK/sysroot/usr/include
#--disable-yasm
#--disable-asm
#--disable-debug \
#--enable-small \
#--disable-stripping \
#--enable-gpl \
#C:/Cplusplus/ffmpeg/ffmpeg342
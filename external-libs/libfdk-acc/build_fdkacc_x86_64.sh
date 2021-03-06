#!/bin/sh

export TMPDIR=$(pwd)/build_temp

NDK=C:/Cplusplus/ffmpeg/android-ndk-r15c
SYSROOT=$NDK/platforms/android-21/arch-x86_64/
TOOLCHAIN=$NDK/toolchains/x86_64-4.9/prebuilt/windows-x86_64
CROSS_COMPILE=$TOOLCHAIN/bin/x86_64-linux-android-

CFLAGS=""
export CXX="${CROSS_COMPILE}g++ --sysroot=${SYSROOT}"
export LDFLAGS=" -L$SYSROOT/usr/lib  $CFLAGS "
export CXXFLAGS=$CFLAGS
export CFLAGS=$CFLAGS
export CC="${CROSS_COMPILE}gcc --sysroot=${SYSROOT}"
export AR="${CROSS_COMPILE}ar"
export LD="${CROSS_COMPILE}ld"
export AS="${CROSS_COMPILE}gcc"

PREFIX=$(pwd)/android/x86_64
ADDITIONAL_CONFIGURE_FLAG=


function build_one {
	./configure \
		--prefix=$PREFIX \
		--enable-shared \
		--enable-static \
		--host=x86_64-linux \
		$ADDITIONAL_CONFIGURE_FLAG

	make clean
	make 
	make install

}

build_one
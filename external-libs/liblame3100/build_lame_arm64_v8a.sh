#!/bin/sh

export TMPDIR=$(pwd)/build_temp

NDK=C:/Cplusplus/ffmpeg/android-ndk-r15c
SYSROOT=$NDK/platforms/android-21/arch-arm64/
TOOLCHAIN=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/windows-x86_64
CROSS_COMPILE=$TOOLCHAIN/bin/aarch64-linux-android-

CFLAGS=" -I$SYSROOT/usr/include"
LDFLAGS=" -L$SYSROOT/usr/lib -L$TOOLCHAIN/aarch64-linux-android/lib"

export CPPFLAGS=$CFLAGS
export CFLAGS=$CFLAGS
export CXXFLAGS=$CFLAGS
export LDFLAGS=$LDFLAGS

export AS="${CROSS_COMPILE}as"
export LD="${CROSS_COMPILE}ld"
export CXX="${CROSS_COMPILE}g++ --sysroot=${SYSROOT}"
export CC="${CROSS_COMPILE}gcc --sysroot=${SYSROOT}"
export NM="${CROSS_COMPILE}nm"
export STRIP="${CROSS_COMPILE}strip"
export RANLIB="${CROSS_COMPILE}ranlib"
export AR="${CROSS_COMPILE}ar"

PREFIX=$(pwd)/android/arm64-v8a
ADDITIONAL_CONFIGURE_FLAG=

function build_one {
	./configure \
		--prefix=$PREFIX \
		--enable-static \
		--enable-shared \
		--disable-frontend \
		--host=aarch64-linux \
		$ADDITIONAL_CONFIGURE_FLAG

	make clean
	make -j4
	make install

}

build_one

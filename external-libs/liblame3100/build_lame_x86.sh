#!/bin/sh

export TMPDIR=$(pwd)/build_temp

NDK=C:/Cplusplus/ffmpeg/android-ndk-r15c
SYSROOT=$NDK/platforms/android-14/arch-x86/
TOOLCHAIN=$NDK/toolchains/x86-4.9/prebuilt/windows-x86_64
CROSS_COMPILE=$TOOLCHAIN/bin/i686-linux-android-

CFLAGS=" -I$SYSROOT/usr/include"
LDFLAGS=" -L$SYSROOT/usr/lib -L$TOOLCHAIN/i686-linux-android/lib"

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

PREFIX=$(pwd)/android/x86
ADDITIONAL_CONFIGURE_FLAG=


function build_one {
	./configure \
		--prefix=$PREFIX \
		--enable-static \
		--enable-shared \
		--disable-frontend \
		--host=i686-linux \
		$ADDITIONAL_CONFIGURE_FLAG

	make clean
	make 
	make install

}

build_one
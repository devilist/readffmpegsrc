#!/bin/sh

export TMPDIR=$(pwd)/build_temp

NDK=C:/Cplusplus/ffmpeg/android-ndk-r15c
SYSROOT=$NDK/platforms/android-14/arch-arm
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/windows-x86_64
CROSS_COMPILE=$TOOLCHAIN/bin/arm-linux-androideabi-

CFLAGS=" -I$SYSROOT/usr/include -march=armv7-a -O2 -mfloat-abi=softfp -ffast-math -mfpu=vfp"
LDFLAGS=" -L$SYSROOT/usr/lib -L$TOOLCHAIN/arm-linux-androideabi/lib"

export CPPFLAGS=$CFLAGS
export CFLAGS=$CFLAGS
export CXXFLAGS=$CFLAGS
export LDFLAGS=$LDFLAGS

export AS="${CROSS_COMPILE}as"
export LD="${CROSS_COMPILE}ld"
export CXX="${CROSS_COMPILE}g++ --sysroot=${SYSROOT}"
export CC="${CROSS_COMPILE}gcc --sysroot=${SYSROOT} -march=armv7-a"
export NM="${CROSS_COMPILE}nm"
export STRIP="${CROSS_COMPILE}strip"
export RANLIB="${CROSS_COMPILE}ranlib"
export AR="${CROSS_COMPILE}ar"

PREFIX=$(pwd)/android/armv7-a
ADDITIONAL_CONFIGURE_FLAG=


function build_one {
	./configure \
		--prefix=$PREFIX \
		--enable-static \
		--enable-shared \
		--disable-frontend \
		--host=arm-linux-androideabi \
		$ADDITIONAL_CONFIGURE_FLAG

	make clean
	make -j4
	make install

}

build_one
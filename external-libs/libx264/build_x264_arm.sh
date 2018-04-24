#!/bin/sh

export TMPDIR=$(pwd)/build_temp

NDK=C:/Cplusplus/ffmpeg/android-ndk-r15c
SYSROOT=$NDK/platforms/android-14/arch-arm
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/windows-x86_64
CROSS_COMPILE=$TOOLCHAIN/bin/arm-linux-androideabi-

PREFIX=$(pwd)/android/arm
ADDITIONAL_CONFIGURE_FLAG=

function build_one {
	./configure \
		--prefix=$PREFIX \
		--disable-asm \
		--enable-shared \
		--enable-static \
		--enable-strip \
		--enable-pic \
		--host=arm-linux-androideabi \
		--cross-prefix=$CROSS_COMPILE \
		--sysroot=$SYSROOT \
		--extra-cflags="-Os -fpic" \
		--extra-ldflags="" \
		$ADDITIONAL_CONFIGURE_FLAG

	make clean
	make -j4
	make install

}

build_one
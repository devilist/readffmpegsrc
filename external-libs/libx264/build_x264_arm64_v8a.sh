#!/bin/sh

export TMPDIR=$(pwd)/build_temp

NDK=C:/Cplusplus/ffmpeg/android-ndk-r15c
SYSROOT=$NDK/platforms/android-21/arch-arm64/
TOOLCHAIN=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/windows-x86_64
CROSS_COMPILE=$TOOLCHAIN/bin/aarch64-linux-android-

PREFIX=$(pwd)/android/arm64-v8a
ADDITIONAL_CONFIGURE_FLAG=

function build_one {
	./configure \
		--prefix=$PREFIX \
		--enable-shared \
		--enable-static \
		--enable-pic \
		--enable-strip \
		--host=aarch64-linux \
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

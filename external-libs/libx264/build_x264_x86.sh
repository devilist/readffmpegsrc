#!/bin/sh

export TMPDIR=$(pwd)/build_temp

NDK=C:/Cplusplus/ffmpeg/android-ndk-r15c
SYSROOT=$NDK/platforms/android-14/arch-x86/
TOOLCHAIN=$NDK/toolchains/x86-4.9/prebuilt/windows-x86_64
CROSS_COMPILE=$TOOLCHAIN/bin/i686-linux-android-

PREFIX=$(pwd)/android/x86
ADDITIONAL_CONFIGURE_FLAG=


function build_one {
	./configure \
		--prefix=$PREFIX \
		--disable-asm \
		--enable-shared \
		--enable-static \
		--enable-pic \
		--enable-strip \
		--host=i686-linux \
		--cross-prefix=$CROSS_COMPILE \
		--sysroot=$SYSROOT \
		--extra-cflags="-Os -fpic" \
		--extra-ldflags="" \
		$ADDITIONAL_CONFIGURE_FLAG

	make clean
	make 
	make install

}

build_one
#!/bin/sh

export TMPDIR=$(pwd)/build_temp

NDK=C:/Cplusplus/ffmpeg/android-ndk-r15c
SYSROOT=$NDK/platforms/android-14/arch-arm
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/windows-x86_64
CROSS_COMPILE=$TOOLCHAIN/bin/arm-linux-androideabi-

PREFIX=$(pwd)/android/armv7-a
ADDITIONAL_CONFIGURE_FLAG=

# 针对arm-v7a的CPU打开了neon的优化运行指令，并且打开了O2优化，这很重要
# --disable-asm 如果不禁掉asm指令，则意味着将会禁止neon的指令

function build_one {
	./configure \
		--prefix=$PREFIX \
		--disable-asm \
		--disable-cli \
		--enable-static \
		--enable-shared \
		--enable-pic \
		--enable-strip \
		--host=arm-linux-androideabi \
		--cross-prefix=$CROSS_COMPILE \
		--sysroot=$SYSROOT \
		--extra-cflags="-Os -fpic -march=armv7-a -O2 -mfloat-abi=softfp -mfpu=neon" \
		--extra-ldflags="" \
		$ADDITIONAL_CONFIGURE_FLAG

	make clean
	make -j4
	make install

}

build_one
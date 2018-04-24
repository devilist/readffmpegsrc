#!/bin/bash
#设置编译中临时文件目录
export TMPDIR=$(pwd)/build_temp
#NDK路径
NDK=C:/Cplusplus/ffmpeg/android-ndk-r15c
#编译针对的平台，这里选择最低支持android-14, arm架构，生成的so库是放在libs/armeabi文件夹下的，
SYSROOT=$NDK/platforms/android-14/arch-arm
# 工具链的路径，arm-linux-androideabi-4.9 与PLATFORM对应
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/windows-x86_64
CROSS_COMPILE=$TOOLCHAIN/bin/arm-linux-androideabi-

ARCH=arm
CPU=armv7-a
#编译后的文件输出路径
PREFIX=$(pwd)/build_output/android/$CPU


# x264
X264_INCLUDE=$(pwd)/external-libs/libx264/android/armv7-a/include
X264_LIB=$(pwd)/external-libs/libx264/android/armv7-a/lib
# fdk-acc
FDKACC_INCLUDE=$(pwd)/external-libs/libfdk-acc/android/armv7-a/include
FDKACC_LIB=$(pwd)/external-libs/libfdk-acc/android/armv7-a/lib
# lame
LAME_INCLUDE=$(pwd)/external-libs/liblame3100/android/armv7-a/include
LAME_LIB=$(pwd)/external-libs/liblame3100/android/armv7-a/lib

EXTRA_CFLAGS="-I$X264_INCLUDE -I$FDKACC_INCLUDE -I$LAME_INCLUDE -march=$CPU -mfloat-abi=softfp -mfpu=neon"
EXTRA_LDFLAGS="-L$X264_LIB -L$FDKACC_LIB -L$LAME_LIB"
ADDITIONAL_CONFIGURE_FLAG=

function build_one {
	./configure \
		--prefix=$PREFIX \
		--disable-stripping \
		--disable-ffmpeg \
		--disable-ffplay \
		--disable-ffprobe \
		--disable-ffserver \
		--disable-symver \
		--disable-avdevice \
		--disable-devices \
		--disable-indevs \
		--disable-outdevs \
		--disable-debug \
		--disable-yasm \
		--disable-asm \
		--disable-doc \
		--disable-postproc \
		--disable-filters \
		--enable-static \
		--enable-shared \
		--enable-cross-compile \
		--enable-small \
		--enable-gpl \
		--enable-nonfree \
		--enable-version3 \
		--enable-libx264 \
		--enable-libfdk-aac \
		--enable-libmp3lame \
		--disable-encoders \
		--enable-encoder=libx264 \
		--enable-encoder=libfdk_aac \
		--enable-encoder=libmp3lame \
		--enable-encoder=pcm_s161e \
		--enable-encoder=libvo_aacenc \
		--disable-decoders \
		--enable-decoder=h264 \
		--enable-decoder=aac \
		--enable-decoder=mp3 \
		--enable-decoder=pcm_s161e \
		--enable-decoder=aac_latm \
		--enable-muxers \
		--enable-muxer=flv \
		--enable-muxer=wav \
		--enable-muxer=adts \
		--disable-demuxers \
		--enable-demuxer=flv \
		--enable-demuxer=wav \
		--enable-demuxer=aac \
		--disable-parsers \
		--enable-parser=aac \
		--disable-bsfs \
		--enable-bsf=h264_mp4toannexb \
		--enable-bsf=acc_adtstoasc \
		--enable-protocols \
		--enable-zlib \
		--enable-avfilter \
		--cross-prefix=$CROSS_COMPILE \
		--target-os=android \
		--arch=$ARCH \
		--cpu=$CPU \
		--sysroot=$SYSROOT \
		--extra-cflags="-Os -fpic $EXTRA_CFLAGS" \
		--extra-ldflags="$EXTRA_LDFLAGS" \
		$ADDITIONAL_CONFIGURE_FLAG

		make clean
		make -j4
		make install
}

build_one
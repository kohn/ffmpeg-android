#!/bin/bash

. abi_settings.sh $1 $2 $3

pushd lame-3.99.5

make clean

case $1 in
    armeabi-v7a | armeabi-v7a-neon)
        HOST=arm-linux
        ;;
    x86)
        HOST=i686-linux
        ;;
    x86_64)
        HOST=x86_64-linux

esac

./configure \
    --with-pic \
    --with-sysroot="$NDK_SYSROOT" \
    --host="$HOST" \
    --enable-static \
    --disable-shared \
    --prefix="${TOOLCHAIN_PREFIX}" \
    --enable-cross-compile \
    --disable-shared || exit 1

#     --enable-arm-neon="$ARM_NEON" \

make -j${NUMBER_OF_CORES} install || exit 1

popd

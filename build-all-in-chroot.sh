#!/bin/bash

ARCHITECTURES=( armhf i386 amd64 )

# Build for all architectures

for ARCH in ${ARCHITECTURES[@]}; do
  ./build-toxcore-in-chroot.sh $ARCH
done

# Create libs directory

SCRIPT_DIR=$(dirname $(readlink -f "$0"))
BUILD_DIR=$SCRIPT_DIR/build
LIBS_DIR=$BUILD_DIR/libs

rm -rf $LIBS_DIR
mkdir -p $LIBS_DIR

# Copy libs into desired directory structure

for ARCH in ${ARCHITECTURES[@]}; do
  mkdir -p $LIBS_DIR/$ARCH
  cp -d $BUILD_DIR/$ARCH/libs/libsodium/lib/libsodium.so* $LIBS_DIR/$ARCH
  cp -d $BUILD_DIR/$ARCH/libs/toxcore/lib/libtoxcore.so* $LIBS_DIR/$ARCH
done

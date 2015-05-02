#!/bin/bash

ARCHITECTURES=( armhf i386 amd64 )

# Build for all architectures

for ARCH in ${ARCHITECTURES[@]}; do
  ./build-toxcore-in-chroot.sh $ARCH
done

# Create libs and include directories

SCRIPT_DIR=$(dirname $(readlink -f "$0"))
BUILD_DIR=$SCRIPT_DIR/build
LIBS_DIR=$BUILD_DIR/libs
INCLUDE_DIR=$BUILD_DIR/include/tox

rm -rf $LIBS_DIR
mkdir -p $LIBS_DIR

rm -rf $INCLUDE_DIR
mkdir -p $INCLUDE_DIR

# Copy libs into desired directory structure

for ARCH in ${ARCHITECTURES[@]}; do
  mkdir -p $LIBS_DIR/$ARCH
  cp -d $BUILD_DIR/$ARCH/libs/libsodium/lib/libsodium.so* $LIBS_DIR/$ARCH
  cp -d $BUILD_DIR/$ARCH/libs/toxcore/lib/libtoxcore.so* $LIBS_DIR/$ARCH
done

# Copy include files into include directory

cp $BUILD_DIR/armhf/libs/toxcore/include/tox/tox.h $INCLUDE_DIR
cp $BUILD_DIR/armhf/libs/toxcore/include/tox/tox_old.h $INCLUDE_DIR

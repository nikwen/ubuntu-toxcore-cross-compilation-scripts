#!/bin/bash

# This follows the official compilation instructions: https://github.com/irungentoo/toxcore/blob/master/INSTALL.md#most-unix-like-oses

if [ $# == 0 ] || [ "$1" == "armhf" ]; then
	ARCH="armhf"
	ARGS="--host=arm-linux-gnueabihf"
elif [ "$1" == "i386" ]; then
	ARCH="i386"
	ARGS="--host=i686-linux-gnu CFLAGS=-m32 CXXFLAGS=-m32 LDFLAGS=-m32"
elif [ "$1" == "amd64" ]; then
	ARCH="amd64"
	ARGS="--host=x86_64-linux-gnu CFLAGS=-m64 CXXFLAGS=-m64 LDFLAGS=-m64"
else
	echo "Error: '$1' is no supported architecture."
	exit
fi

SCRIPT_DIR=$(dirname $(readlink -f "$0"))

BUILD_DIR=$SCRIPT_DIR/build/$ARCH

LIBSODIUM_DIR=$BUILD_DIR/libsodium
TOXCORE_DIR=$BUILD_DIR/toxcore
INSTALL_DIR=$BUILD_DIR/libs
LIBSODIUM_INSTALL_DIR=$INSTALL_DIR/libsodium
TOXCORE_INSTALL_DIR=$INSTALL_DIR/toxcore

# Recreate build directories

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR $LIBSODIUM_DIR $TOXCORE_DIR $INSTALL_DIR $LIBSODIUM_INSTALL_DIR $TOXCORE_INSTALL_DIR

cd $BUILD_DIR

git clone git://github.com/jedisct1/libsodium.git
cd $LIBSODIUM_DIR
git checkout tags/1.0.0
./autogen.sh
./configure $ARGS --prefix=$LIBSODIUM_INSTALL_DIR
make
make install
cd ..

git clone git://github.com/irungentoo/toxcore.git
cd $TOXCORE_DIR
autoreconf -i
./configure $ARGS --with-libsodium-headers=$LIBSODIUM_INSTALL_DIR/include --with-libsodium-libs=$LIBSODIUM_INSTALL_DIR/lib --disable-tests --prefix=$TOXCORE_INSTALL_DIR
make
make install

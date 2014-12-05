#!/bin/bash

# Needs to be run as root!

# This follows the official compiling instructions: https://github.com/irungentoo/toxcore/blob/master/INSTALL.md#most-unix-like-oses

# In order to be run in a click chroot using the click chroot maint command, all sudo calls were removed from this script.

SCRIPT_DIR=$(dirname $(readlink -f "$0"))

BUILD_DIR=$SCRIPT_DIR/build

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
./configure --host=arm-linux-gnueabihf --prefix=$LIBSODIUM_INSTALL_DIR
make
make install
ldconfig
cd ..

git clone git://github.com/irungentoo/toxcore.git
cd $TOXCORE_DIR
autoreconf -i
./configure --host=arm-linux-gnueabihf --with-libsodium-headers=$LIBSODIUM_INSTALL_DIR/include --with-libsodium-libs=$LIBSODIUM_INSTALL_DIR/lib --disable-tests --prefix=$TOXCORE_INSTALL_DIR
make
make install

#!/bin/bash

if [ $# == 0 ] || [ "$1" == "armhf" ]; then
	ARCH="armhf"
elif [ "$1" == "i386" ]; then
	ARCH="i386"
elif [ "$1" == "amd64" ]; then
	ARCH="amd64"
else
	echo "Error: '$1' is no supported architecture."
	exit
fi

SCRIPT_DIR=$(dirname $(readlink -f "$0"))

# Command needs to be run as root (=> maint) because chroot does not support sudo
click chroot -a $ARCH -f ubuntu-sdk-14.10 -s utopic maint $SCRIPT_DIR/build-toxcore.sh $ARCH

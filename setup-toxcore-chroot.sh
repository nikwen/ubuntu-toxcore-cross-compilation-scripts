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

echo $ARCH

echo "====================================="
echo "========== Creating chroot =========="
echo "====================================="
echo

sudo click chroot -a $ARCH -f ubuntu-sdk-15.04 -s utopic create
sudo click chroot -a $ARCH -f ubuntu-sdk-15.04 -s utopic upgrade

echo
echo "====================================="
echo "=== Installing packages in chroot ==="
echo "====================================="
echo

sudo click chroot -a $ARCH -f ubuntu-sdk-15.04 -s utopic maint apt-get install -y build-essential libtool autotools-dev automake checkinstall check git yasm libopus-dev libvpx-dev

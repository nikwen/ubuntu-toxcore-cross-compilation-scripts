#!/bin/bash

echo "====================================="
echo "========== Creating chroot =========="
echo "====================================="
echo

sudo click chroot -a armhf -f ubuntu-sdk-14.10 -s utopic create
sudo click chroot -a armhf -f ubuntu-sdk-14.10 -s utopic upgrade

echo
echo "====================================="
echo "=== Installing packages in chroot ==="
echo "====================================="
echo

sudo click chroot -a armhf -f ubuntu-sdk-14.10 -s utopic maint apt-get install build-essential libtool autotools-dev automake checkinstall check git yasm libopus-dev libvpx-dev

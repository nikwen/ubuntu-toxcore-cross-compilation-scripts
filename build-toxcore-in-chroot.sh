#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f "$0"))

# Command needs to be run as root (=> maint) because chroot does not support sudo
click chroot -a armhf -f ubuntu-sdk-14.10 -s utopic maint $SCRIPT_DIR/build-toxcore.sh

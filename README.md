Scripts for cross-compiling the toxcore library for the armhf architecture on Ubuntu 
====================================================================================

This repository contains a set of scripts to compile the [toxcore library](https://github.com/irungentoo/toxcore "toxcore on Github") for the armhf architecture in a chroot on Ubuntu.

In order to be able to run the scripts, you need to install the Ubuntu SDK first. You can follow the instructions included in the Ubuntu SDK documentation for that: http://developer.ubuntu.com/start/ubuntu-sdk/installing-the-sdk/

Then you need to run the following command to set up a new click chroot for building toxcore or to update an already existing one with the required software.
```bash
./setup-toxcore-chroot.sh
```

Afterwards, you can build toxcore using this command:
```bash
./build-toxcore-in-chroot.sh
```

This script will execute the `build-toxcore.sh` script in the chroot we created.
Never execute that script yourself! Always use the `build-toxcore-in-chroot.sh` script.

The library files can then be found in `build/libs/toxcore/lib`. The include files reside in `build/libs/toxcore/include`.

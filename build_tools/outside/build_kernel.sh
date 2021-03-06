#!/bin/bash
echo "starting the build..." | boxes -d parchment
set -e 
set -o pipefail
mkdir -p build
cd build


echo "download and build the xillinx linux kernel; install the kernel modules into the rootfs" | boxes -d parchment
BRANCH=xilinx-v2016.4
git clone --branch $BRANCH --depth 1 https://github.com/Xilinx/linux-xlnx.git linux-xlnx.git

ARCH=arm
CROSS=arm-linux-gnueabi-
MAKE="make CROSS_COMPILE=$CROSS ARCH=$ARCH KCONFIG_CONFIG=../../boot/kernel.config"
(cd linux-xlnx.git; git checkout tags/xilinx-v2016.4 -b xilinx-v2016.4 )
(cd linux-xlnx.git; yes "" | $MAKE oldconfig || echo "")
(cd linux-xlnx.git; $MAKE -j$(nproc) )
(cd linux-xlnx.git; $MAKE ../../boot/devicetree.dtb )
(cd linux-xlnx.git; $MAKE -j$(nproc) modules)
(cd linux-xlnx.git; $MAKE INSTALL_MOD_PATH=../kernel_modules modules_install )

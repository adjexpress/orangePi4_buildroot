#!/bin/bash

set -e

echo $BASE_DIR
source "$BASE_DIR"/host/environment-setup


BOARD_DIR="$(dirname $0)"
# UBOOT_DIR="$BOARD_DIR/bootloader/uboot"
UBOOT_DIR=`find $BASE_DIR/build -name 'uboot-*' -type d`
RKBIN="$BOARD_DIR/tools/rkbin"
RK3399_SYS_TEXT_BASE=`grep SYS_TEXT_BASE $BOARD_DIR/config/uboot/orangepi-rk3399_defconfig | sed 's/^.*=//;s/"//g'`


install -m 0644 -D $BOARD_DIR/extlinux_sd.conf $BINARIES_DIR/sdcard/extlinux/extlinux.conf
install -m 0644 -D $BOARD_DIR/extlinux_emmc.conf $BINARIES_DIR/emmc/extlinux/extlinux.conf
# install -m 0644 -D $BOARD_DIR/parameters_emmc_gpt.txt $BINARIES_DIR/parameters_gpt.txt
install -m 0644 -D $BOARD_DIR/parameters_gpt.txt $BINARIES_DIR/parameters_gpt.txt
install -m 0644 -D $BOARD_DIR/MiniLoaderAll.bin $BINARIES_DIR/MiniLoaderAll.bin

# idbloader
#
# Package the idbloader.img from Rockchip binary:
$RKBIN/tools/mkimage -n rk3399 -T rksd -d $RKBIN/bin/rk33/rk3399_ddr_800MHz_v1.25.bin $BINARIES_DIR/idbloader.img
cat $RKBIN/bin/rk33/rk3399_miniloader_v1.26.bin >> $BINARIES_DIR/idbloader.img

# u-boot
#
# Package u-boot.bin into miniloader loadable format:
$RKBIN/tools/loaderimage --pack --uboot $UBOOT_DIR/u-boot-dtb.bin $BINARIES_DIR/uboot.img $RK3399_SYS_TEXT_BASE

# Generate the uboot script
$UBOOT_DIR/tools/mkimage -C none -A arm -T script -d $BOARD_DIR/boot_emmc.cmd $BINARIES_DIR/emmc/boot.scr
$UBOOT_DIR/tools/mkimage -C none -A arm -T script -d $BOARD_DIR/boot_sdcard.cmd $BINARIES_DIR/sdcard/boot.scr
# install -m 0644 -D $BOARD_DIR/boot.env  $BINARIES_DIR/boot.env

# copy boot logo
install -m 0644 -D $BOARD_DIR/logo/logo.bmp  $BINARIES_DIR/logo.bmp

# Trust
#
# Package bl31.bin into miniloader loadable format:
$BOARD_DIR/mk_rk-trust.sh $RKBIN $BINARIES_DIR

# EMMC Loader
#
# Used for firmware upgrade to eMMC with rkdeveloptool
# Package from ddr.bin, usbplug.bin, miniloader.bin 
$BOARD_DIR/mk_emmc-loader.sh $RKBIN $BINARIES_DIR

# link firmware dir
mkdir -p $TARGET_DIR/system/etc/
ln -sf /lib/firmware/ $TARGET_DIR/system/etc/firmware


# # << attention: this works only with prebuilt gcc-linaro-6.3 >>
# # build Rockchip UBoot, Trust and Loader from Rockchip repo: 
# cd $UBOOT_DIR
# ./make.sh rk3399
# 
# cd $BOARD_DIR

# copy Binaries to BINARIES_DIR:
# cp $UBOOT_DIR/rk3399_loader*  $BINARIES_DIR/miniloader.bin
# cp $UBOOT_DIR/trust.img  $BINARIES_DIR/trust.img
# cp $UBOOT_DIR/uboot.img  $BINARIES_DIR/uboot.img



# $BINARIES_DIR/erase_flash.sh
# $BINARIES_DIR/write_flash.sh 

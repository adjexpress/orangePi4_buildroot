#!/bin/bash

# BOARD_DIR="$(dirname $0)"
# BINARIES_DIR="../../../output/images"
# RKBIN="$BOARD_DIR/tools/rkbin"
# flashtool="$RKBIN/tools/rkdeveloptool"
# upt="$RKBIN/tools/upgrade_tool"


## for rockchip uboot
# 
# # put device to firmware upgrade mode:
# # and update loader on emmc
# # then write firmware on emmc
write_rk_bin() {
    # $flashtool db $BINARIES_DIR/rk3399_emmc_loader.bin
    $flashtool db $BINARIES_DIR/MiniLoaderAll.bin
    sleep .5
    $flashtool ul $BINARIES_DIR/MiniLoaderAll.bin
    $flashtool wl 0x6000 $BINARIES_DIR/trust.img
    $flashtool wl 0x8000 $BINARIES_DIR/boot_emmc.vfat
    $flashtool wl 0x40000 $BINARIES_DIR/rootfs.ext2
    $flashtool wl 0x4000 $BINARIES_DIR/uboot.img
    $flashtool rd
}


## for oss uboot
write_oss_bin() {

    $flashtool db $BINARIES_DIR/MiniLoaderAll.bin
    sleep .5
    $flashtool ul $BINARIES_DIR/MiniLoaderAll.bin
    $flashtool wl 0x40 $BINARIES_DIR/idbloader.img
    $flashtool wl 0x4000 $BINARIES_DIR/u-boot.itb
    $flashtool wl 0x8000 $BINARIES_DIR/boot_emmc.vfat
    $flashtool wl 0x40000 $BINARIES_DIR/rootfs.ext2
    $flashtool rd
}

write_rk_bin

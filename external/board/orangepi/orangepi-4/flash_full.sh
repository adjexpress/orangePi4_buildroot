#!/bin/bash

BOARD_DIR="$(dirname $0)"
BINARIES_DIR="../../../output/images"
RKBIN="$BOARD_DIR/tools/rkbin"
flashtool="$RKBIN/tools/rkdeveloptool"
upt="$RKBIN/tools/upgrade_tool"

. $BOARD_DIR/tools/flash_erase.sh
. $BOARD_DIR/tools/flash_gpt.sh
sleep 1
. $BOARD_DIR/tools/flash_write.sh


# $flashtool db $BINARIES_DIR/MiniLoaderAll.bin
# sleep .5
# $flashtool wl 0x8000 $BINARIES_DIR/boot_emmc.vfat
# $flashtool rd

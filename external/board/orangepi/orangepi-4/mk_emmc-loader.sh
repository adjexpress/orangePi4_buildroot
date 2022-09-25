#!/usr/bin/env bash
cat >$2/RK3399MINIALL.ini <<EOF
[CHIP_NAME]
NAME=RK330C
[VERSION]
MAJOR=1
MINOR=24
[CODE471_OPTION]
NUM=1
Path1=$1/bin/rk33/rk3399_ddr_800MHz_v1.25.bin
Sleep=1
[CODE472_OPTION]
NUM=1
Path1=$1/bin/rk33/rk3399_usbplug_v1.26.bin
[LOADER_OPTION]
NUM=2
LOADER1=FlashData
LOADER2=FlashBoot
FlashData=$1/bin/rk33/rk3399_ddr_800MHz_v1.25.bin
FlashBoot=$1/bin/rk33/rk3399_miniloader_v1.26.bin
[OUTPUT]
PATH=$2/rk3399_emmc_loader.bin
EOF
$1/tools/boot_merger $2/RK3399MINIALL.ini
rm -rf $2/RK3399MINIALL.ini

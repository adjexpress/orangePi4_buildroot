#!/usr/bin/env bash
cat >$2/RK3399TRUST.ini <<EOF
[VERSION]
MAJOR=1
MINOR=0
[BL30_OPTION]
SEC=0
[BL31_OPTION]
SEC=1
PATH=$1/bin/rk33/rk3399_bl31_v1.35.elf
ADDR=0x00040000
[BL32_OPTION]
SEC=0
[BL33_OPTION]
SEC=0
[OUTPUT]
PATH=$2/trust.img
EOF

## The following give kernel panic when running the command stress
# [BL32_OPTION]
# SEC=1
# PATH=$1/bin/rk33/rk3399_bl32_v2.01.bin
# ADDR=0x08400000

$1/tools/trust_merger $2/RK3399TRUST.ini
rm -rf $2/RK3399TRUST.ini

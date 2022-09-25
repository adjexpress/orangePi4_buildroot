#!/bin/bash

# BOARD_DIR="$(dirname $0)"
# BINARIES_DIR="../../../output/images"
# RKBIN="$BOARD_DIR/tools/rkbin"
# flashtool="$RKBIN/tools/rkdeveloptool"
# upt="$RKBIN/tools/upgrade_tool"


# put device to firmware upgrade mode:
# and write GPT partition table on emmc:
write_gpt_table(){
    $flashtool db $BINARIES_DIR/MiniLoaderAll.bin
    sleep .5
    $flashtool gpt $BINARIES_DIR/parameters_gpt.txt
    $flashtool rd
}

write_gpt_table

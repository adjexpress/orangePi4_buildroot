#!/bin/bash

# BOARD_DIR="$(dirname $0)"
# BINARIES_DIR="../../../output/images"
# RKBIN="$BOARD_DIR/tools/rkbin"
# flashtool="$RKBIN/tools/rkdeveloptool"
# upt="$RKBIN/tools/upgrade_tool"


erase() {
    $upt EF $BINARIES_DIR/MiniLoaderAll.bin
}

erase

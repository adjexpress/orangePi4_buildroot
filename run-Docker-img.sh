#!/bin/bash
CONTAINET_SRC_PATH="/opt/buildroot"
CONTAINET_LAB_PATH="/opt/opi4_build_env"
HOST_SRC_PATH="/home/$USER/workspace/linux/buildroot/buildroot"
HOST_LAB_PATH="$PWD/external/"

function bind_mount(){
    # unlink $CONTAINET_LAB_PATH
    ln -sf $HOST_LAB_PATH $CONTAINET_LAB_PATH
}

function run_image(){
    docker run  \
        --privileged=true  \
        -it \
        -i \
        -e USER_ID=$(id -u) \
        -e GROUP_ID=$(id -g) \
        -v /dev:/dev \
        -v $HOST_SRC_PATH:$CONTAINET_SRC_PATH \
        -v $HOST_LAB_PATH:$CONTAINET_LAB_PATH \
        build_env \
        zsh
}

function start_all(){
    bind_mount
    run_image
}

function cleanup {
  echo "Removing links"
  unlink $CONTAINET_LAB_PATH
}
trap cleanup EXIT
start_all

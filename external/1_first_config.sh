# source .env
# make -C ../buildroot menuconfig
CONFIG=opi_4_rk3399_defconfig

mkdir -p output
# cp local.mk.tmp output/local.mk
if [ ! -f output/.config ];then
    echo "no previuse config found, configuring with ${CONFIG}"
    make BR2_EXTERNAL=$PWD O=$PWD/output -C ../buildroot $CONFIG
else
    echo "previuse config found, leaving"
    export "BR2_EXTERNAL=$PWD"
fi

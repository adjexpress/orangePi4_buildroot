This repository contains external tree
To build *firmware, linux and Qt5 **SDK***  and flash firmware on **OrangePi4**  device

 You need **docker** installed and on host system
 *(for portablity all build operation runs inside docker image)*


 External tree structure:
 ```
└── external
    ├── board
    │   └── orangepi
    │       └── orangepi-4		# board specific
    │           ├── config		# package's cofiguration
    │           ├── logo			# logo folder
    │           ├── overlays		# board specific rootfs overlyes
    │           ├── patch		# packages patch
    │           ├── src			# source of offline packages
    │           └── tools		# tools for build and flash firmware
    ├── configs				# buildroot configuration for orangepi-4 board
    └── package				# external  packages recipes
```


## How to:

## **Prepare environment:**

1. build docker image:
 first clone this repo:
[workspace_container]( github.com/adjexpress/workspace_container)

	check your internet connection and
	run `build-Docker-img.sh` as root
	wait until image build process finish.
2. in root directory of this repo edit `env.sh` file and set ***HOST_SRC_PATH*** varible to **buildroot root directory**.
like this:
	```
	HOST_SRC_PATH="/home/user/buildroot"
	```

3. now from this repo run `run-Docker-img.sh` script as root to enter to the workspace container

* * *
## **Build**:
In container run  `auto.sh` script to start building
it will download about 6 GB of data and need  26 GB of storage space
If every thing goes well after few houres *(depends on your network, storage and CPU)* build will finish successfully with this output:

```
INFO: hdimage(sdcard.img): adding partition 'loader1' (in MBR) from 'idbloader.img' ...
INFO: hdimage(sdcard.img): adding partition 'loader2' (in MBR) from 'uboot.img' ...
INFO: hdimage(sdcard.img): adding partition 'trust' (in MBR) from 'trust.img' ...
INFO: hdimage(sdcard.img): adding partition 'boot' (in MBR) from 'boot_sd.vfat' ...
INFO: hdimage(sdcard.img): adding partition 'rootfs' (in MBR) from 'rootfs.ext4' ...
INFO: hdimage(sdcard.img): adding partition '[MBR]' ...
INFO: hdimage(sdcard.img): adding partition '[GPT header]' ...
INFO: hdimage(sdcard.img): adding partition '[GPT array]' ...
INFO: hdimage(sdcard.img): adding partition '[GPT backup]' ...
INFO: hdimage(sdcard.img): writing GPT
INFO: hdimage(sdcard.img): writing protective MBR
INFO: hdimage(sdcard.img): writing MBR
```
if you want to add or remove packages, features and ...
just use this commands :
```
cd output
make menuconfig
```
save your configuration and
```
make
```

if any thing goes wrong, after fixing that  you can agai run `auto.sh` or instead use this commands:
 ```
cd  output
 make
```
* * *
 ## **Flash**:
 The build process will build both SDcard  and EMMC image.
 Images are located in *output/images* directory.
 you can now exit docker container by `exit` command.
 **SD image:**
 SDcard image name is `sdcard.img`
 you can use `dd` command to write image to SDcard, like this:
 ```
dd if=output/images/sdcard.img of=/dev/sdX bs=1M
```
where ***X*** in **sdX** is a number that represent your SDcard device.
insert SDcar into device and plug power suply.

*note that SDcard boot priority is aftet EMMC, therefoe to boot from SDcard you need to **erase** EMMC*
use `board/orangepi/orangepi-4/tools/flash_erase.sh` script to fully erase flash.

**EMMC image:**
Make sure your user is in ***wheel*** group (for archlinux users).

Hold **recovery button** on your device and plug usb cable to usb guest ( *type-c connector*) in OrangePi4 and wait for *rockusb device* in `Maskrom mode`.
Now from *board/orangepi/orangepi-4* directory run `flash_full.sh` script as root.

This will erase, repartition and write images to device's EMMC.

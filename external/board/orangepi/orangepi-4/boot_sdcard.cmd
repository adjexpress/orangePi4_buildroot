
setenv load_addr "0x6000000" # "0x9000000"
setenv splsh_load_addr "0x41F80000"
setenv bootlogo "false"
setenv devicetree_name "rk3399-orangepi-4.dtb"
setenv kernel_name "Image"
setenv logo_name "logo.bmp"
setenv bootdefargs "earlyprintk quiet"
setenv earlycon "off"
setenv earlyconopt "earlycon=uart8250,mmio32,0xff1a0000"
setenv loglevel "0"
setenv rootfstype "ext4"
setenv rootdev "/dev/mmcblk1p5"
setenv rootdevopt "rw rootwait"
setenv consoleargs "consoleblank=0"
setenv console "serial"
setenv consoleopt "1500000n8"

if test -e ${devtype} ${devnum} boot.env; then
	load ${devtype} ${devnum} ${load_addr} boot.env
	env import -t ${load_addr} ${filesize}
fi

if test "${earlycon}" = "on"; then 
	if test "${console}" = "display" || test "${console}" = "both"; then setenv consoleargs "console=tty1 ${consoleargs}"; fi
	setenv consoleargs "${earlyconopt} ${consoleargs}";
else
	if test "${console}" = "display" || test "${console}" = "both"; then setenv consoleargs "console=tty1 ${consoleargs}"; fi
	if test "${console}" = "serial" || test "${console}" = "both"; then setenv consoleargs "console=ttyS2,${consoleopt} ${consoleargs}"; fi
fi

setenv bootargs "${bootdefargs} ${consoleargs} loglevel=${loglevel} root=${rootdev} rootfstype=${rootfstype} ${rootdevopt}"

if test "${bootlogo}" = "true"; then 
	if fatload mmc ${devnum}:${distro_bootpart} ${load_addr} ${logo_name}; then
		cp.b ${load_addr} ${splsh_load_addr} $filesize
		setenv splashimage ${splsh_load_addr}
	fi
fi
fatload mmc ${devnum}:${distro_bootpart} ${fdt_addr_r} ${devicetree_name}
fatload mmc ${devnum}:${distro_bootpart} ${kernel_addr_r} ${kernel_name}

booti ${kernel_addr_r} - ${fdt_addr_r}

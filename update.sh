#!/bin/bash

echo "making eMMC bootable";
cd /media/sda1/r64-boot

chmod 755 install_emmc.sh
./install_emmc.sh

fatlabel /dev/mmcblk0p1 BPI-BOOT
e2label /dev/mmcblk0p2 rootfs

echo "mounting boot";
mkdir -p /mnt/emmc/boot
mount /dev/mmcblk0p1 /mnt/emmc/boot

mkdir -p /mnt/emmc/boot/bananapi/bpi-r64/linux
mkdir -p /mnt/emmc/boot/bananapi/bpi-r64/linux/dtb

echo "mcopying kernel";

rm /mnt/emmc/boot/bananapi/bpi-r64/linux/uImage
cp /media/sda1/r64-boot/bpi_bananapi-r64-kernel.bin /mnt/emmc/boot/bananapi/bpi-r64/linux/uImage
echo "copying dts";

rm /mnt/emmc/boot/bananapi/bpi-r64/linux/dtb/image-mt7622-bananapi-bpi-r64.dtb
cp /media/sda1/r64-boot/image-mt7622-bananapi-bpi-r64.dtb /mnt/emmc/boot/bananapi/bpi-r64/linux/dtb/image-mt7622-bananapi-bpi-r64.dtb

echo "copying uEnv";
rm /mnt/emmc/boot/bananapi/bpi-r64/linux/uEnv.txt
cp /media/sda1/r64-boot/uEnv.txt /mnt/emmc/boot/bananapi/bpi-r64/linux/uEnv.txt


echo "unmounting boot";
sync
umount /dev/mmcblk0p1
echo "copying rootfs";
dd if=/media/sda1/r64-boot/root.ext4 of=/dev/mmcblk0p2 bs=128k
echo "done, unplug power, change bootswitch to 0, remove SD card, and power again. It should start from eMMC now. ";


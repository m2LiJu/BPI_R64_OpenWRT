#!/bin/bash

echo "mounting boot";
tar xvzf r64-init-emmc-boot.tar.gz

cp update.sh  r64-boot/
cp uEnv.txt   r64-boot/

git pull https://git.openwrt.org/openwrt/openwrt.git 
cd openwrt
./scripts/feeds update -a
./scripts/feeds install -a

echo "creating OpenWRT config";
cp ../ext4_diffconfig .config

echo "copying kernel config";
rm  target/linux/mediatek/mt7622/config-5.4

cp ../config-5.4 target/linux/mediatek/mt7622/
cp ../1000-bpi-R64-mt7622-wifi.patch target/linux/mediatek/patches-5.4/

make defconfig

#change -jx if you have less resources

make -j7

echo "copying kernel,dt, rootfs";
cp build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/bpi_bananapi-r64-kernel.bin  ../r64-boot/
cp build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/image-mt7622-bananapi-bpi-r64.dtb  ../r64-boot/
cp build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/root.ext4  ../r64-boot/

echo "done. Copy folder r64-boot into root folder of USB drive (at least 4GB needed)";

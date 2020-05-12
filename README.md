# BPI_R64_OpenWRT
OpenWRT on BPI R64 from eMMC

Latest OpenWRT with kernel 5.4.40 on BPI R64 running from eMMC. 

u-boot and scripts preparing boot partition from frank-w

Prerequests:
1. Ubuntu 18.04 on host for compilation
2. uSD card 8GB for Ubuntu image for BPI R64
3. USB key at least 4GB
4. UART converter to connect debug pins of BPI R64
5. Some spare time. 

Write BPI R64 ubuntu image into uSD
Google Drive : https://drive.google.com/open?id=1zrOSS2QJPirSwoK5yJFx10SiOtxRjXPt


BUILDING:

On host machine if you newer compile OpenWRT read about prerequest on OpenWRT site. 

Clone all files from here and run 
./make_OpenWRT.sh
This should clone OpenWRT git, configure, build it and create folder r64-boot wirh all nesesery files for step 2. 
It is a long process, depends on network speed and CPU power it make take from 30min to few hours. 
It will compile a lot of extra librarys and applications like python3. I need them to run Home Assistance on BPI R64. You can remove them if you need emmc space on R64. 

After done, copy folder r64-boot into root folder of USB drive (at least 4GB needed). I tested only on FAT32.  


WARNING!!!!!!!!!!

eMMC of BPI R64 will be erased, all data will be lost. Do a backup of all settings if you need them. 

Insert uSD card with ubuntu image card into BPI R64, swith boot switch into '1', connect UART converter into debug connectors and power on. Ubuntu will start from SD.
pass is root, username bananapi

insert USB key then type in console:

mount /dev/sda1 /media/sda1
/media/sda1/r64-boot/update.sh
It will ask if proceed with format rootfs partition. type y
Whole process should take around 2 minutes. You will see confirmation. 

At this stage you should have eMMC programmed and ready to boot. 
unmount USB key, turn off power, remove uSD, change boot switch to 0 and power on. 
R64 should boot from eMMC now.

Wifi is working but TX power stuck on 6 dbm. I will update soon how to fix that. 

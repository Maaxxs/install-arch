#!/bin/bash

# set all variables!!

ROOT="/dev/sda1"        # change it to your root partition
swape=0                 # change it to 1 to activate swap
SWAP="/dev/sda2"        # if swap enabled, change it to your swap partition
wifi=0                  # change to 1 if you need wifi. e.g. on a laptop!

mkfs.ext4 -L ROOT $ROOT
mount $ROOT /mnt
if [ $swape -eq 1 ]; then
  mkswap -L SWAP $SWAP
  swapon $SWAP
fi

if [ $wifi -eq 0 ]; then
    pacstrap /mnt base base-devel grub bash-completion
elif [ $wifi -eq 1 ]; then
    pacstrap /mnt base base-devel grub bash-completion dialog wpa_supplicant
else
    echo "Change variable 'wifi' to something valid!"
    exit
fi

# downloading the other three scripts and moving them to your harddisk
wget https://raw.githubusercontent.com/Maaxxs/install-arch/master/2-system.sh
wget https://raw.githubusercontent.com/Maaxxs/install-arch/master/3-basic.sh
wget https://raw.githubusercontent.com/Maaxxs/install-arch/master/4-prog.sh
cp ./2-system.sh /mnt/
cp ./3-basic.sh /mnt/
cp ./4-prog.sh /mnt/
# set all rights, so that the new user can also execute these scripts
chmod 777 /mnt/2-system.sh
chmod 777 /mnt/3-basic.sh
chmod 777 /mnt/4-prog.sh

genfstab -Up /mnt >> /mnt/etc/fstab

clear
echo "####################################################################"
echo "#####  You're going to be logged in into your new arch system  #####"
echo "#####  EDIT '2-system.sh' and then execute the script  #############"
echo "####################################################################"
sleep 3
arch-chroot /mnt

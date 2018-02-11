#!/bin/bash

# again, set all variables

printerSupport=0    # 0 = off, 1 = on
grafik=1            # 1 = 'xf86-video-nouveau' open-source-nvidia driver:
                    #       (for intelligent switching between intel HD graphics and your NVIDIA graphics card)
                    # 2 = 'nvidia and nvidia-settings'
                    # 3 = 'xf86-video-intel' driver. only intel HD graphics
                    # 4 = 'virtualbox-guest-modules-arch' virtualbox driver (only for installation in virtualbox!)

# check if there is an internet connection
if ping -c 1 archlinux.org >> /dev/null 2>&1; then
    echo "internet connections avaible"
else
    echo "Establish an internet connection first!"
    exit
fi

if [ $printerSupport -eq 0 ]; then
    sudo pacman -S acpid ntp avahi cronie --noconfirm
    sudo systemctl enable acpid avahi-daemon cronie ntpd
elif [ $printerSupport -eq 1 ]; then
    sudo pacman -S acpid ntp avahi cronie cups --noconfirm
    sudo systemctl enable acpid avahi-daemon cronie ntpd org.cups.cupsd.service
else
    echo "Change variable 'printerSupport' to something valid"
    exit
fi
sudo ntpd -gq

if [ $grafik -eq 1 ]; then
    sudo pacman -S xf86-video-nouveau --noconfirm
elif [ $grafik -eq 2 ]; then
    sudo pacman -S nvidia nvidia-settings --noconfirm
elif [ $grafik -eq 3 ]; then
    sudo pacman -S xf86-video-intel --noconfirm
elif [ $grafik -eq 4 ]; then
    sudo pacman -S virtualbox-guest-modules-arch virtualbox-guest-iso --noconfirm
else
    echo "Change the varibale grafik to something valid"
    exit
fi

sudo pacman -S xorg-server xorg-xinit xfce4 xfce4-goodies lightdm lightdm-gtk-greeter networkmanager network-manager-applet nm-connection-editor alsa-tools alsa-utils pulseaudio-alsa pavucontrol --noconfirm
sudo systemctl enable lightdm NetworkManager

# installing AUR helper Trizen
sudo pacman -S git --no-confirm
git clone https://aur.archlinux.org/trizen.git
cd ~/trizen
makepkg -rsi PKGBUILD --no-confirm
rm -rf ~/trizen

# german keyboard layout:
sudo localectl set-x11-keymap de pc105 nodeadkeys

# cleaning up
rm -f ~/3-basic.sh
clear
echo "########## BASIC INSTALLATION COMPLETE #############"
echo "################### rebooting ... ##################"
sleep 4
reboot

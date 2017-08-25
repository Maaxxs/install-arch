#!/bin/bash

### variables
me="max" #change it to your username
grafik=1 #1=open-source-nvidia driver: xf86-video-nouveau || 2=nvidia and nvidia-settings

pacman -S acpid ntp avahi cronie --noconfirm #cups
systemctl enable acpid avahi-daemon cronie ntpd #org.cups.cupsd.service
sudo ntpd -gq

if [ $grafik=1 ]; then
    pacman -S xf86-video-nouveau --noconfirm
elif [ $grafik=2 ]; then
    pacman -S nvidia nvidia-settings --noconfirm
elif [ $grafik=3 ]; then
    printf '2\nY' | pacman -S virtualbox-guest-utils
else
    echo "Change the varibale grafik to something valid"
fi

pacman -S xorg-server xorg-xinit xfce4 xfce4-goodies lightdm lightdm-gtk-greeter networkmanager network-manager-applet nm-connection-editor --noconfirm
systemctl enable lightdm NetworkManager
pacman -S alsa-tools alsa-utils pulseaudio-alsa pavucontrol --noconfirm
pacman -S git --noconfirm
sudo -u $me gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53
sudo -u $me git clone https://aur.archlinux.org/cower.git
sudo -u $me git clone https://aur.archlinux.org/pacaur.git

cd /home/$me/cower
sudo -u $me makepkg -rsi PKGBUILD --noconfirm
cd /home/$me/pacaur
sudo -u $me makepkg -rsi PKGBUILD --noconfirm
cd && rm -Rf /home/$me/cower /home/$me/pacaur
echo "################### Congrats. PACAUR INSTALLED #################"
#german keyboard layout:
localectl set-x11-keymap de pc105 nodeadkeys

rm -f /home/$me/3-basic.sh
echo "########## BASIC INSTALLATION COMPLETE #############"
echo "########## rebooting ... "
sleep 4
reboot

#!/bin/bash

### variables
#username="max"      # change it to your username
grafik=1            # 1 = open-source-nvidia driver: xf86-video-nouveau (for intelligent switching between intel HD graphics and your NVIDIA graphics card)
                    # 2 = nvidia and nvidia-settings
                    # 3 = xf86-video-intel driver. only intel HD graphics
                    # 4 = virtualbox driver (only for installation in virtualbox!)
printerSupport=0    # 0 = off, 1 = on

if [ $printerSupport = 0 ]; then
    sudo pacman -S acpid ntp avahi cronie --noconfirm
    sudo systemctl enable acpid avahi-daemon cronie ntpd
elif [ $printerSupport = 1 ]; then
    sudo pacman -S acpid ntp avahi cronie cups --noconfirm
    sudo systemctl enable acpid avahi-daemon cronie ntpd org.cups.cupsd.service
else
    echo "Change variable 'printerSupport' to something valid"
fi
sudo ntpd -gq

if [ $grafik = 1 ]; then
    sudo pacman -S xf86-video-nouveau --noconfirm
elif [ $grafik = 2 ]; then
    sudo pacman -S nvidia nvidia-settings --noconfirm
elif [ $grafik = 3 ]; then
    sudo pacman -S xf86-video-intel --noconfirm
elif [ $grafik = 4 ]; then
    printf '2\nY' | sudo pacman -S virtualbox-guest-utils
else
    echo "Change the varibale grafik to something valid"
fi

sudo pacman -S xorg-server xorg-xinit xfce4 xfce4-goodies lightdm lightdm-gtk-greeter networkmanager network-manager-applet nm-connection-editor alsa-tools alsa-utils pulseaudio-alsa pavucontrol --noconfirm
sudo systemctl enable lightdm NetworkManager
# installing AUR helper PACAUR now
sudo pacman -S git --noconfirm
#sudo -u $username gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53
#sudo -u $username git clone https://aur.archlinux.org/cower.git
#sudo -u $username git clone https://aur.archlinux.org/pacaur.git

#cd /home/$username/cower
#sudo -u $username makepkg -rsi PKGBUILD --noconfirm
#cd /home/$username/pacaur
#sudo -u $username makepkg -rsi PKGBUILD --noconfirm
#cd && rm -Rf /home/$username/cower /home/$username/pacaur
#echo "################### Congrats. PACAUR INSTALLED #################"

gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53
git clone https://aur.archlinux.org/cower.git
git clone https://aur.archlinux.org/pacaur.git

cd /home/$username/cower
makepkg -rsi PKGBUILD --noconfirm
cd /home/$username/pacaur
makepkg -rsi PKGBUILD --noconfirm
cd && rm -Rf /home/$username/cower /home/$username/pacaur
echo "################### Congrats. PACAUR INSTALLED #################"


#german keyboard layout:
localectl set-x11-keymap de pc105 nodeadkeys

rm -f /home/$username/3-basic.sh
echo "########## BASIC INSTALLATION COMPLETE #############"
echo "########## rebooting ... "
sleep 4
reboot

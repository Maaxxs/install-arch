#!/bin/bash

# set all variables !
me="max"                                # change this to your username
hostname="arch"                         # your hostname
langenc="LANG=de_DE.UTF-8"              # your encoding standard
language="LANGUAGE=de_DE"               # your system language
keymap="KEYMAP=de-latin1-nodeadkeys"    # your keymap. that is the standard german keyboard
otherOS=0                               # set to 1 if grub should be able to detect another installed OS and add it automaticly
harddrive="/dev/sda"                    # enter your harddrive, where you want to install grub

echo $hostname > /etc/hostname
echo $langenc > /etc/locale.conf
echo $language >> /etc/locale.conf
echo $keymap > /etc/vconsole.conf
rm -f /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime

useradd -m -g users -G wheel,audio,video -s /bin/bash $me
echo "Please enter your password for your username $me:"
passwd $me

cp /etc/sudoers .
sed /'%wheel ALL=(ALL) ALL'/s/#// ./sudoers > /etc/sudoers

cp /etc/locale.gen .
sed /#de_DE/s/#// ./locale.gen > /etc/locale.gen
locale-gen

if [ $otherOS=1 ]; then
  pacman -S os-prober --noconfirm
fi
grub-mkconfig -o /boot/grub/grub.cfg
grub-install $harddrive
mv /3-basic.sh /home/$me/
rm -f /2-system.sh
echo "####################################################################"
echo "logout and reboot your new ARCH ;) you should be able to login..."
echo "After you logged in AND established an internet connection, EDIT the 3. script and run it."

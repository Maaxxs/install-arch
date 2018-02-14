#!/bin/bash

# set all variables !
username="max"                          # change this to your username
hostname="arch"                         # your hostname
enc="LANG=de_DE.UTF-8"                  # your encoding standard
language="LANGUAGE=de_DE"               # your system language
keymap="KEYMAP=de-latin1-nodeadkeys"    # your keymap. that is the standard german keyboard
harddrive="/dev/sda"                    # enter your harddrive (not partition),
                                        # where you want to install grub

echo $hostname > /etc/hostname
echo $enc > /etc/locale.conf
echo $language >> /etc/locale.conf
echo $keymap > /etc/vconsole.conf
rm -f /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime

useradd -m -g users -G wheel,audio,video -s /bin/bash $username
echo "#################################################################"
echo "###  Please enter your password for your username $username:  ###"
passwd $username

cp /etc/sudoers .
sed /'%wheel ALL=(ALL) ALL'/s/#// ./sudoers > /etc/sudoers

cp /etc/locale.gen .
sed /#de_DE/s/#// ./locale.gen > /etc/locale.gen
locale-gen

# getting os-prober to check for other systems
sudo pacman -S os-prober --no-confirm
grub-mkconfig -o /boot/grub/grub.cfg
grub-install $harddrive

# moving scripts to the home folder
mv /3-basic.sh /home/$username/
mv /4-prog.sh /home/$username/
# cleaning up. 2nd script is not needed anymore
rm -f /2-system.sh

clear
echo "####################################################################"
echo "logout and reboot your new ARCH ;) you should be able to login..."
echo "After you logged in AND established an internet connection, EDIT the 3rd script and run it."

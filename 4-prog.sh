#!/bin/bash

# uncomment the programs you want
# and comment the ones you don't

progs=(
arc-gtk-theme 
arc-icon-theme 
baobab 
blueman 
bluez 
bluez-utils 
breeze 
catfish 
chromium 
davfs2 
dosfstools 
evince 
faenza-icon-theme 
firefox 
firefox-i18n-de 
gdb 
geeqie 
gimp 
git
gnome-calculator 
gparted 
gtk-engine-murrine 
gvfs 
gvfs-gphoto2 
gvfs-mtp 
gvfs-nfs 
hexchat 
# hplip 
htop 
hunspell-de 
jupyter 
jupyter-nbconvert 
libreoffice-fresh 
libreoffice-fresh-de 
light-locker 
lightdm-gtk-greeter-settings 
most 
networkmanager-openconnect 
noto-fonts 
numix-gtk-theme 
nvim
openssh 
papirus-icon-theme 
pdfshuffler 
pigz 
playerctl 
pulseaudio-bluetooth 
python-pip 
qt4 
reflector 
rsync 
sshfs 
# steam 
stress 
# teamspeak3 
telegram-desktop 
thunderbird 
thunderbird-i18n-de 
unzip 
# veracrypt 
vim 
vlc 
wget 
# whois 
xarchiver 
xclip 
xcursor-simpleandsoft 
	)

progs_aur=(
# chromium-widevine 
conky-nvidia 
# discord-canary 
# dropbox 
etcher 
# github-desktop 
grub-customizer 
gtk-theme-config 
jmtpfs 
# keybase-bin 
menulibre 
neofetch 
numix-circle-icon-theme-git 
numix-themes-darkblue 
# rambox-bin 
# redshiftgui-bin 
sardi-icons 
simple-mtpfs 
# spotify 
surfn-icons-git 
vibrancy-colors 
vim-gruvbox-git 
# visual-studio-code-bin 
# vivaldi 
woeusb-git 
#wps-office 
#wps-office-extension-german-dictionary 
xfdashboard 
	)

sudo pacman -S ${progs[*]}
trizen -S ${progs_aur[*]}

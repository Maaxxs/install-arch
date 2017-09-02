#!/bin/bash
progs=(
#	firefox firefox-i18n-de
	chromium
#	qt4 vlc
	libreoffice-fresh libreoffice-fresh-de hunspell-de
	thunderbird thunderbird-i18n-de
	catfish gvfs ntfs-3g
	wget git
	gparted dosfstools
	most
	openssh
#	atom
 	vim
#	hplip		# (printer database)
#	geeqie		# Image viewer
#	os-prober 	# tool to detect other OS automatically. after installing run 'grub-mkconfig -o /boot/grub/grub.cfg' as root
	light-locker
# Fonts and Icons
	noto-fonts
	arc-icon-theme
	arc-gtk-theme
	breeze
	)

progs_aur=(
	chromium-widevine
	menulibre
	grub-customizer
	neofetch
	simple-mtpfs   # jmtpfs
#	shotcut
	conky-nvidia
#	iridium-bin
#	vivaldi vivaldi-widevine
#	woeusb-git # create bootable windows usb stick with an iso Image
#	wps-office wps-office-extension-german-dictionary
	etcher
# 	teamviewer
# fonts and icons
	numix-circle-icon-theme-git
	numix-themes-darkblue gtk-engine-murrine
	sardi-icons
	surfn-icons-git
	vibrancy-colors

sudo pacman -S "${progs[*]}"
pacaur -S "${progs_aur[*]}"

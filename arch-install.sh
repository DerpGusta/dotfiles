#!/usr/bin/env bash

if [[ ! $(curl -Is http://www.google.com/ | head -n 1) =~ "200 OK" ]]; then
  echo -e "\e[1;32mYour Internet seems broken. Press Ctrl-C to abort or enter to continue.\e[0m"
  read
fi

name="derp"

timedatectl set-ntp true
wipefs -a /dev/sda1
wipefs -a /dev/sda2
wipefs -a /dev/sda3
wipefs -a /dev/sda
sgdisk -o /dev/sda
sgdisk /dev/sda -n 1::+512M -t 1:ef00 #EFI
sgdisk /dev/sda -n 2::-512M -t 2:8304 #root
sgdisk /dev/sda -n 3 -t 3:8200 #swap
wipefs -a /dev/sda1
wipefs -a /dev/sda2
wipefs -a /dev/sda3

mkfs.vfat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mkswap /dev/sda3

mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/sda3

pacman -S --noconfirm pacman-contrib
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.orig

echo -e "\e[1;32m\n Selecting the fastest servers \n\e[0m"
rankmirrors -n 6 /etc/pacman.d/mirrorlist.orig >/etc/pacman.d/mirrorlist

echo -e "\e[1;32m\n Updating packages\e[0m"
pacman -Sy

echo -e "\e[1;32\nInstalling base packages\e[0m"
pacstrap /mnt base base-devel linux linux-firmware i3-gaps \
open-vm-tools lxdm stow xf86-video-vmware xf86-input-vmmouse

cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist
arch-chroot /mnt pacman -Sy

genfstab -p /mnt >>/mnt/etc/fstab
echo "tytoalba" > /etc/hostname
root_uuid="$(lsblk /dev/sda2 -no uuid)"

echo -e "\e[1;32mAdding user now\e[0m"
arch-chroot /mnt useradd -m -U -G wheel,users -s /bin/bash derp >/dev/null
arch-chroot /mnt usermod -a -G audio,video derp
echo -e "\e[1;32m User derp added\e[0m"
arch-chroot /mnt /bin/bash -c "echo '%wheel ALL=(ALL) NOPASSWD: ALL' >/etc/sudoers.d/wheel"
echo -e "root\nroot" | arch-chroot /mnt passwd root
echo -e "arch\narch" | arch-chroot /mnt passwd derp

echo -e "\e[1;32m\n REFRESHING ARCHLINUX KEYRING\e[0m"
arch-chroot /mnt pacman --noconfirm -Sy archlinux-keyring

echo -e "\e[1;32m\n Installing yay and installing dotfiles\e[0m"
arch-chroot /mnt /bin/bash << EOF
cd /tmp
rm -rf /tmp/yay-bin*
curl -sO https://aur.archlinux.org/cgit/aur.git/snapshot/yay-bin.tar.gz
sudo -u derp tar -xvf yay-bin.tar.gz && cd yay-bin
sudo -u derp makepkg --noconfirm -sirc
cd /tmp
yay -Sy
sudo -u derp git clone --depth 1 https://github.com/DerpGusta/dotfiles.git  /home/$name/dotfiles >/dev/null 2>&1
cd "/home/derp/dotfiles/"
sudo -u derp dirs=(*/); stow "${dirs[@]%/}"
grep "^Color" /etc/pacman.conf >/dev/null || sed -i "s/^#Color$/Color/" /etc/pacman.conf
sed -i "s/-j2/-j$(nproc)/;s/^#MAKEFLAGS/MAKEFLAGS/" /etc/makepkg.conf
EOF

#echo -e "\e[1;32m\n Installing Blackarch Repos \e[0m"
#arch-chroot /mnt /bin/bash <<EOF
#curl -O https://blackarch.org/strap.sh 
#echo 9c15f5d3d6f3f8ad63a6927ba78ed54f1a52176b strap.sh | sha1sum -c
#chmod +x strap.sh
#./strap.sh
#EOF

echo -e "\e[1;32m\n Setting up timezone, bootloader and startup services\e[0m"
cp /etc/systemd/network/20-ethernet.network /mnt/etc/systemd/network/
sed -i '/^\[Network\]/a DNS=1.0.0.1/' /mnt/etc/systemd/network/20-ethernet.network
arch-chroot /mnt /bin/bash <<EOF
locale-gen
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
bootctl install
rmmod pcspkr
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
systemctl enable systemd-networkd
systemctl enable systemd-resolved
systemctl enable vmware-vmblock-fuse.service vmtoolsd.service
systemctl enable lxdm.service
EOF

cat >> /mnt/boot/loader/entries/arch.conf << BOOTEND
title   Arch Linux
linux   /vmlinuz-linux
initrd    /initramfs-linux.img
options   root=UUID=$root_uuid rw
BOOTEND

echo "console-mode 1" >> /mnt/boot/loader/loader.conf

echo -e "\e[1;32m\n Installing packages from packages.csv\e[0m"
ls /mnt/home/$name/dotfiles/

progsfile="/mnt/home/$name/dotfiles/packages.csv"
installpkg(){ arch-chroot /mnt pacman --noconfirm --needed -S "$1" >/dev/null 2>&1 ;}

maininstall() { # Installs all needed programs from main repo.
	echo -e "\e[1;32m\n Installing $1 -> $2 from pacman\e[0m"
	installpkg "$1"
	}

aurinstall() { \
	echo -e "\e[1;32m\n Installing $1 -> $2 from AUR\e[0m"
    arch-chroot /mnt sudo -u "$name" yay -S --noconfirm "$1"
}
installationloop() { \
	([ -f "$progsfile" ] && cp "$progsfile" /mnt/home/$name/dotfiles/progs.csv) || echo -e "\e[1;32mWhere's the damn progsfile?\e[0m" | sed '/^#/d' | eval grep "^[PGA]*," > /mnt/home/$name/dotfiles/progs.csv
	while IFS=, read -r tag program comment; do
		n=$((n+1))
		echo -e "\e[1;32m$comment\e[0m" | grep "^\".*\"$" >/dev/null 2>&1 && comment="$(echo -e "\e[1;32m$comment\[e0m" | sed "s/\(^\"\|\"$\)//g")"
		case "$tag" in
			"A") aurinstall "$program" "$comment" ;;
			*) maininstall "$program" "$comment" ;;
		esac
	done < /mnt/home/derp/dotfiles/progs.csv ;}
installationloop
arch-chroot /mnt sudo -u "$name" ./home/$name/dotfiles/stow.sh

echo -e "\e[1;32m\n Unmounting all the partitons\e[0m"
umount -R /mnt

echo -e "\e[1;31mDONT FORGET UPDATING YOUR DEFAULT PASSWORDS!\e[0m"

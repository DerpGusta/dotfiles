#!/usr/bin/env bash

if [[ ! $(curl -Is http://www.google.com/ | head -n 1) =~ "200 OK" ]]; then
  echo "Your Internet seems broken. Press Ctrl-C to abort or enter to continue."
  exit
fi

read -rsp 'Enter password for root:' rootpass
timedatectl set-ntp true
wipefs -a /dev/sda
sgdisk -o /dev/sda
sgdisk /dev/sda -n 1::+512M -t 1:ef00 #EFI
sgdisk /dev/sda -n 2::-512M -t 2:8304 #root
sgdisk /dev/sda -n 3 -t 3:8200 #swap

mkfs.vfat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mkswap /dev/sda3

mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/sda3

pacman -S --needed --noconfirm pacman-contrib
echo -e "\n\nWait for rankmirrors to complete!!\n\n"
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.orig
rankmirrors -n 6 /etc/pacman.d/mirrorlist.orig >/etc/pacman.d/mirrorlist

pacstrap /mnt base base-devel linux linux-firmware open-vm-tools xf86-video-vmware \
lxdm xf86-input-vmmouse

genfstab -U /mnt >> /mnt/etc/fstab
root_uuid=$(lsblk /dev/sda2 -no uuid)

cp -L /etc/resolv.conf /mnt/etc/resolv.conf

cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/

echo "root:$rootpass" | chpasswd -R /mnt 

ln -sf /mnt/usr/share/zoneinfo/Asia/Kolkata /mnt/etc/localtime
LOCALE="en_US.UTF-8"
sed -i "/$LOCALE/s/^#//" /mnt/etc/locale.gen
echo "LANG=$LOCALE" > /mnt/etc/locale.conf
echo "KEYMAP=us" > /mnt/etc/vconsole.conf
cat "tytoalba" > /mnt/etc/hostname
bootctl install --boot-path=/mnt/boot
touch /mnt/boot/loader/entries/
cat >> "/mnt/boot/loader/entries/arch.conf" << BOOTEND
title   Arch Linux
linux   /vmlinuz-linux
initrd    /initramfs-linux.img
options   root=UUID=$root_uuid rw
BOOTEND

network_file="/mnt/etc/systemd/network/20-wired.conf"
if [[ -f $network_file ]]; then
sed -i '/\[Network\]/a DNS=1.0.0.1' $network_file
fi

curl -O https://blackarch.org/strap.sh
echo 9c15f5d3d6f3f8ad63a6927ba78ed54f1a52176b strap.sh | sha1sum -c - || exit 1
chmod +x strap.sh
arch-chroot /mnt /bin/bash < strap.sh

arch-chroot /mnt /bin/bash <<EOF
locale-gen
systemctl enable systemd-networkd
systemctl enable vmware-vmblock-fuse.service vmtoolsd.service
systemctl enable lxdm.service
EOF

umount -R /mnt

echo "Done! Now all you have to do is run the darbs.sh after reboot"

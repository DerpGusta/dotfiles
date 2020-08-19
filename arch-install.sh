#!/usr/bin/env bash

if [[ ! $(curl -Is http://www.google.com/ | head -n 1) =~ "200 OK" ]]; then
  echo -e "\e[1;32mYour Internet seems broken. Press Ctrl-C to abort or enter to continue.\e[0m"
  read
fi

name="derp"
chroot='arch-chroot /mnt /bin/bash'
chcmd='arch-chroot /mnt'

timedatectl set-ntp true
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

pacman -S --noconfirm pacman-contrib
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.orig
echo -e "\e[1;32m\n Selecting the fastest servers \n\e[0m"
rankmirrors -n 6 /etc/pacman.d/mirrorlist.orig >/etc/pacman.d/mirrorlist
echo -e "\e[1;32m\n Updating packages\e[0m"
pacman -Sy

pacstrap /mnt base base-devel linux linux-firmware i3-gaps \
open-vm-tools lxdm stow xf86-video-vmware xf86-input-vmmouse
cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/ 

genfstab -p /mnt >>/mnt/etc/fstab
root_uuid="$(lsblk /dev/sda2 -no uuid)"
echo -e "\e[1;32mAdding user now\e[0m"
$chcmd groupadd "$name" >/dev/null 2>&1
arch-chroot /mnt useradd -m -g wheel -s /bin/bash "$name" >/dev/null
arch-chroot /mnt usermod -a -G audio,video
arch-chroot /mnt echo -e "root:toor" | chpasswd
arch-chroot /mnt echo -e "$name:arch" | chpasswd

echo -e "\e[1;32m\n REFRESHING ARCHLINUX KEYRING\e[0m"
$chcmd pacman --noconfirm -Sy archlinux-keyring >/dev/null 2>&1
$chmod -c '[[ -f /etc/sudoers ]] && cp "/etc/sudoers" "/etc/sudoers.bak"'

echo -e "\e[1;32m\n Making changes to sudoers\e[0m"
cat >> "/mnt/etc/sudoers" << EOF
Defaults        env_reset
Defaults        mail_badpass
Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"

%wheel ALL=(ALL) NOPASSWD: ALL
root ALL=(ALL:ALL) ALL
%admin ALL=(ALL) ALL
%sudo ALL=(ALL:ALL) ALL
@includedir /etc/sudoers.d
EOF

echo -e "\e[1;32m\n Installing yay and installing dotfiles\e[0m"
$chroot << EOF
cd /tmp
rm -rf /tmp/yay-bin*
curl -sO https://aur.archlinux.org/cgit/aur.git/snapshot/yay-bin.tar.gz &&
sudo -u "$name" tar -xvf yay-bin.tar.gz >/dev/null 2>&1 && cd yay-bin
sudo -u "$name" makepkg --noconfirm -sirc >/dev/null 2>&1
cd /tmp
yay -Sy
sudo -u "$name" git clone --depth 1 https://github.com/DerpGusta/dotfiles.git  /home/$user/dotfiles >/dev/null 2>&1
cd "/home/$user/dotfiles/"
dirs=(*/)
sudo -u "$name" stow "${dirs[@]%/}"
grep "^Color" /etc/pacman.conf >/dev/null || sed -i "s/^#Color$/Color/" /etc/pacman.conf
sed -i "s/-j2/-j$(nproc)/;s/^#MAKEFLAGS/MAKEFLAGS/" /etc/makepkg.conf
EOF

echo -e "\e[1;32m\n Setting up timezone, bootloader and startup services\e[0m"

$chroot <<EOF
locale-gen
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
bootctl install
rmmod pcspkr
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
systemctl enable systemd-networkd
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
ls /mnt/home/$user/dotfiles/

progsfile="/mnt/home/$user/dotfiles/packages.csv"
installpkg(){ $chcmd pacman --noconfirm --needed -S "$1" >/dev/null 2>&1 ;}

maininstall() { # Installs all needed programs from main repo.
	echo -e "\e[1;32m\n Installing $1 -> $2 from pacman\e[0m"
	installpkg "$1"
	}

aurinstall() { \
	echo -e "\e[1;32m\n Installing $1 -> $2 from AUR\e[0m"
    arch-chroot /mnt sudo -u "$name" yay -S --noconfirm "$1" >/dev/null 2>&1
}
installationloop() { \
	([ -f "$progsfile" ] && cp "$progsfile" /mnt/home/$user/dotfiles/progs.csv) || echo -e "\e[1;32mWhere's the damn progsfile?\e[0m" | sed '/^#/d' | eval grep "^[PGA]*," > /mnt/home/$user/dotfiles/progs.csv
	while IFS=, read -r tag program comment; do
		n=$((n+1))
		echo -e "\e[1;32m$comment\e[0m" | grep "^\".*\"$" >/dev/null 2>&1 && comment="$(echo -e "\e[1;32m$comment\[e0m" | sed "s/\(^\"\|\"$\)//g")"
		case "$tag" in
			"A") aurinstall "$program" "$comment" ;;
			*) maininstall "$program" "$comment" ;;
		esac
	done < /mnt/home/$user/dotfiles/progs.csv ;}
installationloop
$chcmd sudo -u "$user" ./home/$user/dotfiles/stow.sh
echo -e "\e[1;32m\n Unmounting all the partitons\e[0m"
umount -R /mnt

echo -e "\e[1;31mDONT FORGET UPDATING YOUR DEFAULT PASSWORDS!\e[0m"

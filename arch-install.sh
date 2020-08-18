#!/usr/bin/env bash

if [[ ! $(curl -Is http://www.google.com/ | head -n 1) =~ "200 OK" ]]; then
  echo "Your Internet seems broken. Press Ctrl-C to abort or enter to continue."
  read
fi

read -rsp 'Enter password for root:' rootpass
echo
name="derp"
read -rsp 'Enter a password for user.' pass1
echo
read -rsp 'Retype password.' pass2
echo
while ! [ "$pass1" = "$pass2" ]; do
    unset pass2
    read -rsp 'Enter a password for that user.' pass1
    read -rsp 'Retype password.' pass2
done 
chroot='arch-chroot /mnt /bin/bash'
chcmd='arch-chroot /mnt'

timedatectl set-ntp true
sgdisk -o /dev/sda
sgdisk /dev/sda -n 1::+512M -t 1:ef00 #EFI
sgdisk /dev/sda -n 2::-512M -t 2:8304 #root
sgdisk /dev/sda -n 3 -t 3:8200 #swap

mkfs.vfat -F32 /dev/sda1
mkfs.ext4 /dev/sda2

mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/sda3

pacman -S --noconfirm pacman-contrib
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.orig
echo -e "\n Selecting the fastest servers \n"
rankmirrors -n 6 /etc/pacman.d/mirrorlist.orig >/etc/pacman.d/mirrorlist
echo -e "\n Updating packages"
pacman -Sy

pacstrap /mnt base base-devel linux linux-firmware i3-gaps \
open-vm-tools lxdm stow xf86-video-vmware xf86-input-vmmouse
cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/ 

genfstab -p /mnt >>/mnt/etc/fstab
root_uuid="$(lsblk /dev/sda2 -no uuid)"
echo "Adding user now"
$chcmd groupadd "$name" >/dev/null 2>&1
arch-chroot /mnt useradd -m -g wheel -s /bin/bash "$name" >/dev/null
arch-chroot /mnt usermod -a -G audio,video
arch-chroot "echo \"$name:$pass1\" | chpasswd"
unset pass1 pass2

echo -e "\n REFRESHING ARCHLINUX KEYRING"
$chcmd pacman --noconfirm -Sy archlinux-keyring >/dev/null 2>&1
$chmod -c '[[ -f /etc/sudoers ]] && cp "/etc/sudoers" "/etc/sudoers.bak"'

echo -e "\n Making changes to sudoers"
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

echo -e "\n Installing yay and installing dotfiles"
$chroot << EOF
cd /tmp
rm -rf /tmp/yay-bin*
curl -sO https://aur.archlinux.org/cgit/aur.git/snapshot/yay-bin.tar.gz &&
sudo -u "$name" tar -xvf yay-bin.tar.gz >/dev/null 2>&1 && cd yay-bin
sudo -u "$name" makepkg --noconfirm -sirc >/dev/null 2>&1
cd /tmp
sudo -u "$name" git clone --depth 1 https://github.com/DerpGusta/dotfiles.git  /home/derp/dotfiles >/dev/null 2>&1
cd "/home/derp/dotfiles/"
dirs=(*/)
sudo -u "$name" stow "${dirs[@]%/}"
grep "^Color" /etc/pacman.conf >/dev/null || sed -i "s/^#Color$/Color/" /etc/pacman.conf
sed -i "s/-j2/-j$(nproc)/;s/^#MAKEFLAGS/MAKEFLAGS/" /etc/makepkg.conf
EOF

echo -e "\n Setting up timezone, bootloader and startup services"

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

echo -e "\n Installing packages from packages.csv"
ls /mnt/home/derp/dotfiles/
$chroot << EOF
progsfile="/home/derp/dotfiles/packages.csv"
installpkg(){ pacman --noconfirm --needed -S "$1" >/dev/null 2>&1 ;}

maininstall() { # Installs all needed programs from main repo.
	installpkg "$1"
	}

aurinstall() { \
    echo -e "Installing \`$1\` ($n of $total) from the AUR. $1 $2\n"
    echo "$aurinstalled" | grep "^$1$" >/dev/null 2>&1 && return
    sudo -u "$name" yay -S --noconfirm "$1" >/dev/null 2>&1
}
installationloop() { \
	([ -f "$progsfile" ] && cp "$progsfile" /home/derp/dotfiles/progs.csv) || echo "Where's the damn progsfile?" | sed '/^#/d' | eval grep "^[PGA]*," > /home/derp/dotfiles/progs.csv
	total=$(wc -l < /home/derp/dotfiles/progs.csv)
	aurinstalled=$(pacman -Qqm)
	while IFS=, read -r tag program comment; do
		n=$((n+1))
		echo "$comment" | grep "^\".*\"$" >/dev/null 2>&1 && comment="$(echo "$comment" | sed "s/\(^\"\|\"$\)//g")"
		case "$tag" in
			"A") aurinstall "$program" "$comment" ;;
			*) maininstall "$program" "$comment" ;;
		esac
	done < /home/derp/dotfiles/progs.csv ;}
installationloop
EOF
echo -e "\n Unmounting all the partitons"
umount -R /mnt


#!/usr/bin/env bash

if [[ ! $(curl -Is http://www.google.com/ | head -n 1) =~ "200 OK" ]]; then
  echo "Your Internet seems broken. Press Ctrl-C to abort or enter to continue."
  exit
fi

read -rsp 'Enter password for root:' rootpass
name="derp"
read -rsp 'Enter a password for user.' pass1
read -rsp 'Retype password.' pass2
while ! [ "$pass1" = "$pass2" ]; do
    unset pass2
    read -rsp 'Enter a password for that user.' pass1
    read -rsp 'Retype password.' pass2
done 
chroot = "arch-chroot /mnt /bin/bash/"

timedatectl set-ntp true
wipefs -a /dev/sda[1-9]*
wipefs -a /dev/sda
sgdisk -o /dev/sda
sgdisk /dev/sda -n 1::+512M -t 1:ef00 #EFI
sgdisk /dev/sda -n 2::-512M -t 2:8304 #root
sgdisk /dev/sda -n 3 -t 3:8200 #swap
wipefs -a /dev/sda[1-9]*
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
lxdm xf86-input-vmmouse i3-gaps git

genfstab -U /mnt >> /mnt/etc/fstab
root_uuid=$(lsblk /dev/sda2 -no uuid)

cp -L /etc/resolv.conf /mnt/etc/resolv.conf

cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/

echo "root:$rootpass" | chpasswd -R /mnt 

LOCALE="en_US.UTF-8"
sed -i "/$LOCALE/s/^#//" /mnt/etc/locale.gen
echo "LANG=$LOCALE" > /mnt/etc/locale.conf
echo "KEYMAP=us" > /mnt/etc/vconsole.conf
echo "tytoalba" > /mnt/etc/hostname

network_file="/mnt/etc/systemd/network/20-ethernet.network"
cp /etc/systemd/network/20-ethernet.network $network_file
sed -i '/\[Network\]/a DNS=1.0.0.1' $network_file
touch /mnt/etc/systemd/network/90-tun-ignore.network
cat > /mnt/etc/systemd/network/90-tun-ignore.network <<EOF
[Match]
Name=tun*

[Link]
Unmanaged=true
EOF

curl -O https://blackarch.org/strap.sh
echo 9c15f5d3d6f3f8ad63a6927ba78ed54f1a52176b strap.sh | sha1sum -c - || exit 1
chmod +x strap.sh
$chroot < strap.sh

echo "Adding user \"$name\"..."
$chroot < groupadd "$name" >/dev/null 2>&1
$chroot < useradd -m -g wheel -s /bin/bash "$name" >/dev/null 2>&1 || usermod -a -G wheel,users,video,audio,$name "$name" && mkdir -p /home/"$name" && chown "$name":wheel /home/"$name"
umount -R /mnt
echo "$name:$pass1" | chpasswd
unset pass1 pass2

echo -e "\n REFRESHING ARCHLINUX KEYRING"
pacman --noconfirm -Sy archlinux-keyring >/dev/null 2>&1

echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
$chroot << EOF
cd /tmp
rm -rf /tmp/yay-bin*
curl -sO https://aur.archlinux.org/cgit/aur.git/snapshot/yay-bin.tar.gz &&
sudo -u "$name" tar -xvf yay-bin.tar.gz >/dev/null 2>&1 && cd yay-bin
sudo -u "$name" makepkg --noconfirm -sirc >/dev/null 2>&1
cd /tmp
sudo -u "$name" git clone --depth 1 https://github.com/DerpGusta/dotfiles.git  ~/ >/dev/null 2>&1
cd /home/derp/dotfiles/
sudo -u "$name" stow $(ls -d */)
grep "^Color" /etc/pacman.conf >/dev/null || sed -i "s/^#Color$/Color/" /etc/pacman.conf
sed -i "s/-j2/-j$(nproc)/;s/^#MAKEFLAGS/MAKEFLAGS/" /etc/makepkg.conf
chsh -s /usr/bin/fish $name >/dev/null 2>&1
echo -e "%wheel ALL=(ALL) ALL #DARBS\n
%wheel ALL=(ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/reboot,/usr/bin/systemctl suspend,/usr/bin/mount,/usr/bin/umount,/usr/bin/pacman -Syu,/usr/bin/pacman -Syyu,/usr/bin/packer -Syu,/usr/bin/packer -Syyu,/usr/bin/pacman -Syyu --noconfirm,/usr/bin/loadkeys,/usr/bin/yay,/usr/bin/pacman -Syyuw --noconfirm" >> /etc/sudoers
EOF

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
$chroot << EOF
$progsfile=/home/derp/dotfiles/packages.csv
installpkg(){ pacman --noconfirm --needed -S "$1" >/dev/null 2>&1 ;}

maininstall() { # Installs all needed programs from main repo.
	installpkg "$1"
	}

aurinstall() { \
    echo -e "Installing \`$1\` ($n of $total) from the AUR. $1 $2\n"
    echo "$aurinstalled" | grep "^$1$" >/dev/null 2>&1 && return
    sudo -u "$name" $aurhelper -S --noconfirm "$1" >/dev/null 2>&1
}

([ -f "$progsfile" ] && cp "$progsfile" /tmp/progs.csv) | sed '/^#/d' | grep "$grepseq" > /tmp/progs.csv
total=$(wc -l < /tmp/progs.csv)
aurinstalled=$(pacman -Qqm)
while IFS=, read -r tag program comment; do
    n=$((n+1))
    echo "$comment" | grep "^\".*\"$" >/dev/null 2>&1 && comment="$(echo "$comment" | sed "s/\(^\"\|\"$\)//g")"
    case "$tag" in
        "A") aurinstall "$program" "$comment" ;;
        *) maininstall "$program" "$comment" ;;
    esac
done < /tmp/progs.csv 
EOF

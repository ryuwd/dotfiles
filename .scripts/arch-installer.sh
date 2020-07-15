#!/bin/bash

# TODO: finish me when I actually need to install arch again

# the target partition to setup the LUKS volume
#SETUP_ROOT_PART="NONESET"
#SETUP_EFI_PART="NONESET"
if [ -z ${SETUP_ROOT_PART} ]; then
    exit 1;
fi

SETUP_HOSTNAME="arch"
SETUP_SHELL="/usr/bin/zsh"
SETUP_USER="username"

REGION="Europe"
CITY="London"
SETUP_LANG="en_GB.UTF-8"
SETUP_LOCALE="${SETUP_LANG} UTF-8"
PACKAGES="linux linux-firmware lvm2 vim zsh man-db man-pages texinfo dhcpcd"

MKINITCPIO_HOOKS="HOOKS=(base udev autodetect keyboard keymap consolefont modconf block encrypt lvm2 filesystems fsck)"
MKINITCPIO_SDHOOKS="HOOKS=(base systemd autodetect keyboard sd-vconsole modconf block sd-encrypt sd-lvm2 filesystems fsck)"


set -euxo pipefail

echo "Assuming internet connectivity..."

loadkeys uk
timedatectl set-ntp true

echo "Setting up LUKS on ${SETUP_ROOT_PART}"

# setup LUKS on ROOT_PARTITION
cryptsetup luksFormat ${SETUP_ROOT_PART}    
cryptsetup open ${SETUP_ROOT_PART} cryptlvm 

pvcreate /dev/mapper/cryptlvm               
vgcreate ArchVols /dev/mapper/cryptlvm      

# Change if needed
lvcreate -l 1G  ArchVols -n boot
lvcreate -L 18G ArchVols -n swap            
lvcreate -L 40G ArchVols -n root            
lvcreate -l 100%FREE ArchVols -n home       

mkfs.ext4 /dev/ArchVols/root
mkfs.ext4 /dev/ArchVols/home
mkswap /dev/ArchVols/swap

mount /dev/ArchVols/root /mnt
mkdir /mnt/home
mount /dev/ArchVols/home /mnt/home
swapon /dev/ArchVols/swap

mount ${SETUP_EFI_PART} /mnt/boot 

echo "FDS and partitioning:"                         >> README_TODO.txt 
echo ""                                              >> README_TODO.txt 
echo "1. Please add these to your mkinitcpio hooks:" >> README_TODO.txt
echo "(after base)       udev            OR systemd" >> README_TODO.txt
echo "(after autodetect) keyboard keymap OR keyboard sd-vconsole" >> README_TODO.txt 
echo "(after block)      encrypt lvm2    OR sd-encrypt sd-lvm2"   >> README_TODO.txt 

SETUP_ROOT_PART_UUID=$(blkid -s UUID -o value ${SETUP_ROOT_PART})


echo "2. Please add these kernel parameters to the bootloader:"                  >> README_TODO.txt 
echo ""                                                                          >> README_TODO.txt 
echo "encrypt hook (default):"                                                   >> README_TODO.txt 
echo "cryptdevice=UUID=${SETUP_ROOT_PART_UUID}:cryptlvm root=/dev/ArchVols/root" >> README_TODO.txt 
echo ""                                                                          >> README_TODO.txt  
echo "systemd hook:"                                                             >> README_TODO.txt 
echo "rd.luks.name=${SETUP_ROOT_PART_UUID}=cryptlvm root=/dev/ArchVols/root"     >> README_TODO.txt 


echo "---------------------------"
echo "Mirror list optimisation"
pacman -S refector
reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

echo "Pacstrap"

pacstrap /mnt ${PACKAGES}

arch-chroot /mnt

# run inside chroot the following:

ln -sf /usr/share/zoneinfo/$REGION/$CITY /etc/localtime
hwclock --systohc

# uncomment en_GB.UTF-8 UTF-8
set -i "#.*${SETUP_LOCALE}/c ${SETUP_LOCALE}" /etc/locale.gen

locale-gen

echo "LANG=${SETUP_LANG}" > /etc/locale.conf
echo "KEYMAP=uk" > /etc/vconsole.conf

echo "${SETUP_HOSTNAME}" > /etc/hostname

echo "127.0.0.1	localhost
::1		localhost
127.0.1.1	${SETUP_HOSTNAME}.localdomain	${SETUP_HOSTNAME}" > /etc/hosts

echo "Mkinitcpio"
sed -i "/HOOKS=/c ${MKINITCPIO_HOOKS}/" /etc/mkinitcpio.conf # test this
mkinitcpio -P

echo "Now please set the root password:"
passwd


echo "Now setting up a user"
useradd -m -G wheel -s $SETUP_SHELL $SETUP_USER

echo "Now please set the password for ${SETUP_USER}:"
passwd ${SETUP_USER}

# set up systemd boot

bootctl install

exit

# end chroot steps

echo "All done. You should check README_TODO.txt."

# Init configs
Configs are managed with [GNU stow](https://www.gnu.org/software/stow/), to init a config run from (project root)
```bash
stow <config-folder>
```
e.g.
```
stow i3
```

### DEPRECATED
Run config init script in the folder scripts/init
```bash
cd scripts/init && bash init_configs.sh
```
This will prompt you for a backup of your current config directory (if it can be found), which you can set using the _config_directory_ variable(defaults to ~/config_test for safety reasons ;)). After the backup the script will symlink all folders in this repo to your config directory and run any scripts in scripts/init (except those defined in variables _ignored_directories_ and _ignored_scripts_ respectively). *RUN AT YOUR OWN RISK! I TAKE NO RESPONSIBILITY FOR LOST FILES!*

# Arch Linux installation
This procedure is heavily based on and copied from [jsherman82's arch linux installation](https://gitlab.com/jsherman82/notes/blob/master/arch.md) with a few tweaks.
The commands below used nvme0n1 naming convention for partitions but the sda naming convention should be equivalent.
The installation will only provide a basic installation (no DE, WM, etc).
Some key features/components of this install:
- Partitions managed with LVM
  - Encryption using LVM on LUKS
  - Separate root and home partition
    - Root partition: 30GiB
    - Home partition: The rest
- UEFI
- GRUB
- Swap partition instead of swap file

Use wifi-menu to connect to network:

Edit /etc/pacman.d/mirrorlist on the Arch computer and paste the faster servers
```
vim /etc/pacmand.d/mirrorlist
```
Update package indexes:
```
# pacman -Syyy
```

Create efi, boot, swap and lvm partitions (in that order for the rest of the command to work):
```
# fdisk /dev/sda
```

Create file systems for the boot and ESP partitions
```
# mkfs.fat -F32 /dev/nvme0n1p1
# mkfs.ext2 /dev/nvme0n1p2
```

Activate swap partition
```
mkswap /dev/nvme0n1p3
swapon /dev/nvme0n1p3
```
Set up encryption
```
# cryptsetup luksFormat /dev/nvme0n1p4
# cryptsetup open --type luks /dev/nvme0n1p4 lvm
```

Set up lvm:
```
# pvcreate --dataalignment 1m /dev/mapper/lvm
# vgcreate volgroup0 /dev/mapper/lvm
# lvcreate -L 30GB volgroup0 -n lv_root
# lvcreate -l 100%FREE volgroup0 -n lv_home
# modprobe dm_mod
# vgscan
# vgchange -ay
```
Create file systems for the root and home partitions
```
# mkfs.ext4 /dev/volgroup0/lv_root
# mkfs.ext4 /dev/volgroup0/lv_home
```

Mount the root partition
```
# mount /dev/volgroup0/lv_root /mnt
```
Create mount directories
```
# mkdir /mnt/boot
# mkdir /mnt/home
```

Mount boot and home directory
```
# mount /dev/nvme0n1p2 /mnt/boot
# mount /dev/volgroup0/lv_home /mnt/home
```

Install arch
```
# pacstrap -i /mnt base linux linux-firmware
```

Generate fstab file
```
# genfstab -U -p /mnt >> /mnt/etc/fstab
```

Change root to arch installation
```
# arch-chroot /mnt
```

Install base packages + vim
```
# pacman -S base-devel grub efibootmgr dosfstools openssh os-prober mtools linux-headers linux-lts linux-lts-headers lvm2 vim
```

Edit /etc/mkinitcpio.conf and add encrypt lvm2 in between block and filesystems

```
# mkinitcpio -p linux
# mkinitcpio -p linux-lts
```
Set and generate locale
```
# vim /etc/locale.gen (uncomment en_US.UTF-8 if you want us UTF-8 locale)
# locale-gen
```

Set root password
```
# passwd
```

Edit /etc/default/grub:
add cryptdevice=<PARTUUID>:volgroup0 to the GRUB_CMDLINE_LINUX_DEFAULT line.
  
If using standard device naming, the option will look like this: cryptdevice=/dev/sda3:volgroup0
```
vim /etc/default/grub
```

Mount ESP partition
```
# mkdir /boot/EFI
# mount /dev/nvme0n1p1 /boot/EFI
```

Install grub for x86_64 efi architecture (you should be able to change the bootloader-id flag to whatever you want, it is not important)
```
# grub-install --target=x86_64-efi  --bootloader-id=grub_uefi --recheck
```

Not sure what this does to be honest...
```
# cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
```

Generate grub-config
```
# grub-mkconfig -o /boot/grub/grub.cfg
```

Exit live environment, unmount devices and restart system (might complain about busy devices but should not matter)
```
$ exit
# umount -a
# reboot
```

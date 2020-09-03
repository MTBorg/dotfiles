# Init configs

Configs are managed with [GNU stow](https://www.gnu.org/software/stow/), to init a config run from (project root)

```bash
stow <config-folder>
```

e.g.

```
stow i3
```

Lots of the configs also the depend on gitsubmodules so be sure to init all submodules:

```
git submodule update --init --recursive
```

# Fonts

Any [nerd font](https://www.nerdfonts.com/)-patched font should work.

# Vim/Neovim
Neovim is used as the editor (there is a config for vim but it is no longer used), and plugins are managed with [vim-plug](https://github.com/junegunn/vim-plug).
Linting, language support, formatting, e.t.c is managed by [coc](https://github.com/neoclide/coc.nvim).

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

#### Connect to internet using either wifi-menu or an ethernet cable

#### Edit /etc/pacman.d/mirrorlist on the Arch computer and paste the faster servers

```
# nvim /etc/pacmand.d/mirrorlist
```

#### Update package indexes:

```
# pacman -Syyy
```

#### Create efi, boot, swap and lvm partitions (in that order for the rest of the command to work):

```
# fdisk /dev/sda
```

#### Create file systems for the boot and ESP partitions

```
# mkfs.fat -F32 /dev/nvme0n1p1
# mkfs.ext2 /dev/nvme0n1p2
```

#### Activate swap partition

```
# mkswap /dev/nvme0n1p3
# swapon /dev/nvme0n1p3
```

#### Set up encryption

```
# cryptsetup luksFormat /dev/nvme0n1p4
# cryptsetup open --type luks /dev/nvme0n1p4 lvm
```

#### Set up lvm:

```
# pvcreate --dataalignment 1m /dev/mapper/lvm
# vgcreate volgroup0 /dev/mapper/lvm
# lvcreate -L 30GB volgroup0 -n lv_root
# lvcreate -l 100%FREE volgroup0 -n lv_home
# modprobe dm_mod
# vgscan
# vgchange -ay
```

#### Create file systems for the root and home partitions

```
# mkfs.ext4 /dev/volgroup0/lv_root
# mkfs.ext4 /dev/volgroup0/lv_home
```

#### Mount the root partition

```
# mount /dev/volgroup0/lv_root /mnt
```

#### Create mount directories

```
# mkdir /mnt/boot
# mkdir /mnt/home
# mkdir /mnt/efi
```

#### Mount the boot, home and EFI partitions

```
# mount /dev/nvme0n1p2 /mnt/boot
# mount /dev/volgroup0/lv_home /mnt/home
# mount /dev/nvme0n1p1 /mnt/efi
```

#### Install base package, linux kernel/firmware (you can skip the `linux-lts` packages if you don't want the LTS-kernel) and other packages

```
# pacstrap -i /mnt base \
  linux \
  linux-firmware \
  linux-headers \
  linux-lts \
  linux-lts-headers \
  grub \
  efibootmgr \
  dosfstools \
  openssh\
  os-prober \
  lvm2 \
  neovim
```

#### Generate fstab file

```
# genfstab -U -p /mnt >> /mnt/etc/fstab
```

#### Change root to arch installation

```
# arch-chroot /mnt
```

#### Configure initial ramdisk

Edit /etc/mkinitcpio.conf and add encrypt lvm2 in between block and filesystems

```
# nvim /etc/mkinitcpio.conf
```

#### Create initial ramdisk

```
# mkinitcpio -p linux
# mkinitcpio -p linux-lts
```

#### Set and generate locale

```
# nvim /etc/locale.gen (uncomment en_US.UTF-8 if you want us UTF-8 locale)
# locale-gen
```

#### Set root password

```
# passwd
```

#### Configure grub

add cryptdevice=<PARTUUID>:volgroup0 to the GRUB_CMDLINE_LINUX_DEFAULT line.
If using standard device naming, the option will look like this: cryptdevice=/dev/nvme0n1p4:volgroup0

```
# nvim /etc/default/grub
```

#### Install grub for x86_64 efi architecture

(you should be able to change the bootloader-id flag to whatever you want, it is not important).
If you have problems with arch installation not showing up in the boot menu try adding the --removable flag to the command below (see this [link](https://wiki.archlinux.org/index.php/GRUB#Default/fallback_boot_path))

```
# grub-install --target=x86_64-efi --efi-directory=/efi  --bootloader-id=grub_uefi --recheck
```

#### Not sure what this does to be honest (something with locales i guess)...

```
# cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
```

#### Generate grub-config

```
# grub-mkconfig -o /boot/grub/grub.cfg
```

#### Exit live environment, unmount devices and restart system (might complain about busy devices but should not matter)

```
$ exit
# umount -a
# reboot
```

### Post-installation

#### Clean up

Remove no longer needed packes

```
sudo pacman -Rs dosfstools
```

PARTITION_DEVICE=/dev/sda
EFI_PARTITION=${PARTITION_DEVICE}1
LVM_PARTITION=${PARTITION_DEVICE}2
MOUNT_BASE=/mnt
LVM_DIR_NAME=lvm
LVM_VOLGROUP_NAME=volgroup0
LVM_ROOT_VOLUME_SIZE=4GB
LVM_SWAP_VOLUME_SIZE=2GB
LVM_ROOT_VOLUME_NAME=lv_root
LVM_HOME_VOLUME_NAME=lv_home
LVM_SWAP_VOLUME_NAME=lv_swap
LVM_ROOT_PARTITION=/dev/mapper/$LVM_VOLGROUP_NAME-$LVM_ROOT_VOLUME_NAME
LVM_HOME_PARTITION=/dev/mapper/$LVM_VOLGROUP_NAME-$LVM_HOME_VOLUME_NAME
LVM_SWAP_PARTITION=/dev/mapper/$LVM_VOLGROUP_NAME-$LVM_SWAP_VOLUME_NAME
# LVM_HOME_PARTITION=/dev/$LVM_VOLGROUP_NAME/$LVM_HOME_VOLUME_NAME
# LVM_SWAP_PARTITION=/dev/$LVM_VOLGROUP_NAME/$LVM_SWAP_VOLUME_NAME
# INCLUDE_LTS=1 #If this variable is set then include an lts-kernel
LOCALE=en_US.UTF-8

function create_partition_table(){
	parted $PARTITION_DEVICE mklabel "gpt"
}

function create_partitions() {
	echo "creating partitions" >&2

	#Efi partition
	echo "creating efi partition" >&2
	parted $PARTITION_DEVICE mkpart primary 0% 500MiB
	parted $PARTITION_DEVICE set 1 esp on
	parted $PARTITION_DEVICE set 1 boot on

	#LVM partition
	echo "creating lvm partition" >&2
	parted $PARTITION_DEVICE mkpart primary 500MiB 100%
}

function create_mount_dirs(){
	echo "creating mount dirs" >&2
	mkdir -p $MOUNT_BASE/home
	mkdir -p $MOUNT_BASE/boot
	mkdir -p $MOUNT_BASE/efi
}

function lvm_setup() {
	echo "setting up lvm..." >&2
	pvcreate --dataalignment 1m $LVM_PARTITION

	echo "creating volume group $LVM_VOLGROUP_NAME on physical volume $LVM_PARTITION" >&2
	vgcreate $LVM_VOLGROUP_NAME $LVM_PARTITION

	echo "creating root volume of size $LVM_ROOT_VOLUME_SIZE" >&2
	lvcreate -L $LVM_ROOT_VOLUME_SIZE $LVM_VOLGROUP_NAME -n $LVM_ROOT_VOLUME_NAME

	echo "creating swap volume of size $LVM_SWAP_VOLUME_SIZE" >&2
	lvcreate -L $LVM_SWAP_VOLUME_SIZE $LVM_VOLGROUP_NAME -n $LVM_SWAP_VOLUME_NAME

	echo "creating home partition using remaining space" >&2
	lvcreate -l 100%FREE $LVM_VOLGROUP_NAME -n $LVM_HOME_VOLUME_NAME

	echo "finishing lvm setup..." >&2
}

function make_fs(){
	echo "making filesystems"
	mkfs.fat -F32 $EFI_PARTITION
	mkfs.ext4 $LVM_ROOT_PARTITION
	mkfs.ext4 $LVM_HOME_PARTITION
}

function make_swap() {
	echo "making swap"
	mkswap $LVM_SWAP_PARTITION
	swapon $LVM_SWAP_PARTITION
}

function mount_() {
	echo "mounting partitions..." >&2

	echo "mounting root partition on $MOUNT_BASE" >&2
	mount $LVM_ROOT_PARTITION $MOUNT_BASE
	
	echo "mounting home partition to $MOUNT_BASE/home" >&2
	mount $LVM_HOME_PARTITION $MOUNT_BASE/home

	echo "mounting EFI partition to $MOUNT_BASE/efi" >&2
	mount $EFI_PARTITION $MOUNT_BASE/efi
}

function gen_fstab() {
	genfstab -U $MOUNT_BASE >> $MOUNT_BASE/etc/fstab
}

function add_initram_encrypt_hooks(){
	sed -i -r "s/^HOOKS=\(.*block/& encrypt lvm2/" /etc/mkinitcpio.conf
}

function create_initial_ramdisk() {
	mkinitcpio -p linux
	[ $INCLUDE_LTS ] && mkinitcpio -p linux-lts
}

function change_root() {
	arch-chroot $MNT_BASE
}

function set_gen_locale() {
	sed -i -r "s/#$LOCALE/$LOCALE/" /etc/locale.gen && locale-gen
}

function main() {
	echo "Running installation"
	create_partition_table
	create_partitions

	# crypt_setup
	# crypt_open

	lvm_setup

	create_mount_dirs

	make_fs
	make_swap

	mount_

	# # TODO: pacstrap

	# genfstab

	# change_root

	# add_initram_encrypt_hooks
	# create_initial_ramdisk
	
	# set_gen_locale
}

main

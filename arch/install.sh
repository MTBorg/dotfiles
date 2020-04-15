PARTITION_DEVICE=/dev/sda
EFI_PARTITION=${PARTITION_DEVICE}1
LVM_PARTITION=${PARTITION_DEVICE}2
MOUNT_BASE=/mnt
CRYPT_NAME=cryptlvm
LVM_VOLGROUP_NAME=volgroup0
LVM_ROOT_VOLUME_SIZE=30GB
LVM_ROOT_VOLUME_NAME=lv_root
LVM_HOME_VOLUME_NAME=lv_home
LVM_ROOT_PARTITION=/dev/$LVM_VOLGROUP_NAME/$LVM_ROOT_VOLUME_NAME
LVM_HOME_PARTITION=/dev/$LVM_VOLGROUP_NAME/$LVM_HOME_VOLUME_NAME

function create_partition_table(){
	parted $PARTITION_DEVICE mklabel "gpt"
}

function create_partitions() {
}

function create_mount_dirs(){
	mkdir $MOUNT_BASE/boot
	mkdir $MOUNT_BASE/efi
}

function crypt_setup() {
	cryptsetup luksFormat --type luks1 $LVM_PARTITION
}

function crypt_open(){
	cryptsetup open $LVM_PARTITION $CRYPT_NAME
}

function lvm_setup() {
	pvcreate --dataalignment 1m /dev/mapper/$CRYPT_NAME
	vgcreate $LVM_VOLGROUP_NAME /dev/mapper/$CRYPT_NAME
	lvcreate -L $LVM_ROOT_VOLUME_SIZE $LVM_VOLGROUP_NAME -n $LVM_ROOT_VOLUME_NAME
	#TODO: Create swap partition
	lvcreate -l 100%FREE $LVM_VOLGROUP_NAME -n $LVM_HOME_VOLUME_NAME
	modprobe dm_mod
	vgscan
	vgchange -ay
}

function make_fs(){
	mkfs.fat -F32 $EFI_PARTITION
	mkfs.ext4 $LVM_ROOT_PARTITION
	mkfs.ext4 $LVM_HOME_PARTITION
}

function mount_() {
	mount /
}

function main() {
	create_partition_table
	create_partitions

	create_mount_dirs

	crypt_setup
	crypt_open

	lvm_setup

	mount_
}

# Attach ISO
VBoxManage storageattach archiso --storagectl IDE --port 1 --device 0 --type dvddrive --medium ./build/iso/archlinux-baseline-2021.02.07-x86_64.iso

# Start VM
vboxmanage startvm archiso --type gui

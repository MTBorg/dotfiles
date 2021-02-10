# Attach ISO
ISO=$(ls build/iso | awk '{print $1}')
VBoxManage storageattach archiso --storagectl IDE --port 1 --device 0 --type dvddrive --medium ./build/iso/$ISO

# Start VM
vboxmanage startvm archiso --type gui

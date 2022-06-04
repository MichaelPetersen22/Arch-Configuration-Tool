grubtheme=$1
grubicon=$2
grubscreen=$3
winPartition=$4
repoDir=$5
message "Configuring GRUB"
workingDIR=$(pwd)
load "$repoDir"
cd /tmp
sudo -u $username git clone "$grub2theme"
cd grub2-themes/
umount -l --recursive /mnt &>/dev/null
mount /dev/"$winPartition" /mnt
./install.sh -t $grubtheme -i $grubicon -s $grubscreen
umount -l /mnt
cd "$workingDIR"/
progressMessage "GRUB Configured"

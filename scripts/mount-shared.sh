#!/usr/bin/env sh
#
# Unmount with `sudo umount /mnt/vb-shared'.
# Doc: https://kb.vmware.com/s/article/60262

sudo mkdir -p /mnt/vb-shared
sudo vmhgfs-fuse .host:/vb-shared /mnt/vb-shared -o subtype=vmhgfs-fuse,allow_other

# TODO
# # Install open-source package
# sudo apt install open-vm-tools
# # or
# # 1. Menu: Virtual Machine > Install VMWare Tools
# # 2. user must be in the sudoers file (logout required)
# usermod -aG sudo user
# # 3.
# tar -C /tmp -zxvf /media/cdrom0/VMware\ Tools/VMwareTools-10.*.tar.gz
# sudo /tmp/vmware-tools-distrib/vmware-install.pl -d

# # create fstab entry for shared drive
# echo -e "\n# shared drive\nvmhgfs-fuse    /mnt/            fuse           defaults,allow_other    0    0" | sudo tee -a /etc/fstab

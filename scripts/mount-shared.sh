#!/usr/bin/env sh
#
# Unmount with `sudo umount /mnt/vb-shared'.
# Doc: https://kb.vmware.com/s/article/60262

sudo mkdir -p /mnt/vb-shared
sudo vmhgfs-fuse .host:/vb-shared /mnt/vb-shared -o subtype=vmhgfs-fuse,allow_other

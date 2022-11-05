#
## Metasploit

# enable postgres for metasploit
sudo systemctl enable postgresql.service
sudo msfdb init

ln -s $HOME/.$USER-sh/config/msfconsole.rc $HOME/.msf4/msfconsole.rc

#
## VMWare

# Install open-source package
sudo apt install open-vm-tools
# or
# 1. Menu: Virtual Machine > Install VMWare Tools
# 2. user must be in the sudoers file (logout required)
usermod -aG sudo user
# 3.
tar -C /tmp -zxvf /media/cdrom0/VMware\ Tools/VMwareTools-10.*.tar.gz
sudo /tmp/vmware-tools-distrib/vmware-install.pl -d

# create fstab entry for shared drive
echo -e "\n# shared drive\nvmhgfs-fuse    /mnt/            fuse           defaults,allow_other    0    0" | sudo tee -a /etc/fstab

#
## Misc

# create links for config files
ln -s $HOME/.$USER.sh/config/xsessionrc $HOME/.xsessionrc

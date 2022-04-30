# Install open-source package
# sudo apt install open-vm-tools

# or

# 1. Menu: Virtual Machine > Install VMWare Tools

# 2. user must be in the sudoers file (logout required)
# usermod -aG sudo user

# 3.
tar -C /tmp -zxvf /media/cdrom0/VMware\ Tools/VMwareTools-10.*.tar.gz 
sudo /tmp/vmware-tools-distrib/vmware-install.pl -d

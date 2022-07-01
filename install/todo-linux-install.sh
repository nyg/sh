#!/usr/bin/env sh

# install software
sudo apt install audacity
sudo apt install wavsteg
sudo apt install asciinema
sudo apt install vim

# enable postgres for metasploit
sudo systemctl enable postgresql.service
sudo msfdb init

# remove useless directories
rm -r $HOME/{Music,Pictures,Public,Templates,Videos}

# create fstab entry for shared drive
echo -e "\n# shared drive\nvmhgfs-fuse    /mnt/            fuse           defaults,allow_other    0    0" | sudo tee -a /etc/fstab

# create links for config files

mkdir -p $HOME/.config/git
ln -s $HOME/.$USER-sh/config/gitconfig $HOME/.config/git/config

ln -s $HOME/.$USER-sh/config/aliases $HOME/.bash_aliases
ln -s $HOME/.$USER.sh/config/xsessionrc $HOME/.xsessionrc
ln -s $HOME/.$USER-sh/config/msfconsole.rc $HOME/.msf4/msfconsole.rc

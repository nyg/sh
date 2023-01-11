#!/usr/bin/env sh

sudo apt install -y \
    vim \
    curl \
    tree \
    htop \
    jq \
    terminator \
    meld \
    vlc \
    # flameshot \
    sshpass \
    gparted \
    samba \
    gnome-tweaks \
    dconf-editor \
    # rdesktop \
    asciinema

sudo apt remove --purge -y \
    nano

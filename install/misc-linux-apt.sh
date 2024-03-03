#!/usr/bin/env sh

sudo apt install -y \
    zsh \
    vim \
    curl \
    tree \
    htop \
    jq \
    terminator \
    meld \
    vlc \
    flameshot \
    sshpass \
    gparted \
    samba \
    gnome-tweaks \
    dconf-editor \
    asciinema \
    # rdesktop

sudo apt remove --purge -y \
    nano

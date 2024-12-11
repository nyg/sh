#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    echo Installing openssh-server…
    sudo apt install -y openssh-server

    echo Enabling ssh.service
    sudo systemctl enable ssh

    echo Linking SSH configuration file…
    ln -s "$HOME/.$USER-sh/etc/ssh/server-config.conf" /etc/ssh/sshd_config.d/custom.conf

    echo Done!
else
    echo Unsupported OS >&2
    exit 1
fi

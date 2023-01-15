#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    echo Installing openssh-server…
    sudo apt install -y openssh-server

    echo Enabling ssh.service
    sudo systemctl enable ssh

    echo Done!
else
    echo Unsupported OS >&2
    exit 1
fi

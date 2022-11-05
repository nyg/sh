#!/usr/bin/env sh
# https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    echo Adding GPG key…
    mkdir -p /etc/apt/keyrings
    curl -s https://packages.microsoft.com/keys/microsoft.asc \
        | gpg --dearmor \
        | sudo tee /etc/apt/keyrings/microsoft-teams.gpg

    echo Adding repository…
    file=/etc/apt/sources.list.d/microsoft-teams.list
    echo -n "deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft-teams.gpg]" \
        | sudo tee $file
    echo " https://packages.microsoft.com/repos/ms-teams stable main" \
        | sudo tee -a $file

    echo Installing Teams…
    sudo apt update
    sudo apt install teams

    echo Done!
else
    echo Could not install Teams >&2
    exit 1
fi

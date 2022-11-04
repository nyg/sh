#!/usr/bin/env sh
# https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    echo Adding GPG key…
    curl https://packages.microsoft.com/keys/microsoft.asc \
        | sudo gpg --dearmor -o /usr/share/keyrings/microsoft-archive-keyring.gpg

    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/ms-teams stable main" > /etc/apt/sources.list.d/teams.list'

    sudo apt update
    sudo apt install teams

else
    echo Could not install VSCodium >&2
    exit 1
fi

echo Done!

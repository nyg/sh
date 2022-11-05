#!/usr/bin/env sh
# https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    echo Adding GPG key…
    key_file=/etc/apt/keyrings/vscodium.gpg
    curl -s https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
        | gpg --dearmor \
        | sudo tee $key_file > /dev/null

    echo Adding repository…
    echo "deb [signed-by=$key_file] https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs vscodium main" \
        | sudo tee /etc/apt/sources.list.d/vscodium.list

    echo Installing VSCodium…
    sudo apt update
    sudo apt install -y codium

    echo Done!
else
    echo Could not install VSCodium >&2
    exit 1
fi

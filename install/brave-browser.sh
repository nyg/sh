#!/usr/bin/env sh
# https://brave.com/linux/#release-channel-installation

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    echo Adding GPG key…
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
        https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

    echo Adding repository…
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" \
        | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    echo Installing Brave…
    sudo apt update
    sudo apt install -y brave-browser

else
    echo Could not install Brave >&2
    exit 1
fi

echo Done!

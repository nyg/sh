#!/usr/bin/env sh
# https://brave.com/linux/#release-channel-installation

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    echo Adding GPG key…
    key=/etc/apt/keyrings/brave-browser.gpg
    curl -fsS https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
        | sudo tee $key > /dev/null

    echo Adding repository…
    echo "deb [arch=amd64 signed-by=$key] https://brave-browser-apt-release.s3.brave.com/ stable main" \
        | sudo tee /etc/apt/sources.list.d/brave-browser.list

    echo Installing Brave…
    sudo apt update
    sudo apt install -y brave-browser

    echo Done!
else
    echo Could not install Brave >&2
    exit 1
fi

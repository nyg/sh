#!/usr/bin/env sh
# https://support.typora.io/Typora-on-Linux/

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    echo Adding GPG key…
    wget -qO - https://typora.io/linux/public-key.asc | sudo tee /etc/apt/trusted.gpg.d/typora.asc

    echo Adding repository…
    sudo add-apt-repository 'deb https://typora.io/linux ./'

    echo Installing Typora…
    sudo apt update
    sudo apt install -y typora

else
    echo Could not install Typora >&2
    exit 1
fi

echo Done!

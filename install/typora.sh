#!/usr/bin/env sh
# https://support.typora.io/Typora-on-Linux/

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    echo Adding GPG key…
    key=/etc/apt/keyrings/typora.asc
    curl -s https://typora.io/linux/public-key.asc \
        | sudo tee $key > /dev/null

    echo Adding repository…
    echo "deb [signed-by=$key] https://typora.io/linux ./" \
        | sudo tee /etc/apt/sources.list.d/typora.list

    echo Installing Typora…
    sudo apt update
    sudo apt install -y typora

    echo Done!
else
    echo Could not install Typora >&2
    exit 1
fi

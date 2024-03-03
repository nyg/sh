#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    echo Adding GPG key…
    key=/etc/apt/keyrings/sublime-text.gpg
    curl -fsS https://download.sublimetext.com/sublimehq-pub.gpg \
        | gpg --dearmor \
        | sudo tee $key > /dev/null

    echo Adding repository…
    echo "deb [arch=$(uname -m) signed-by=$key] https://download.sublimetext.com/ apt/stable/" \
        | sudo tee /etc/apt/sources.list.d/sublime-text.list

    echo Installing Sublime Text…
    sudo apt update
    sudo apt install -y sublime-text

    echo Done!
else
    echo Could not install Sublime Text >&2
    exit 1
fi

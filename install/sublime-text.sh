#!/usr/bin/env sh
# Needs fixing
# https://askubuntu.com/questions/1286545/what-commands-exactly-should-replace-the-deprecated-apt-key
# https://www.digitalocean.com/community/tutorials/how-to-handle-apt-key-and-add-apt-repository-deprecation-using-gpg-to-add-external-repositories-on-ubuntu-22-04
# https://askubuntu.com/questions/1437207/what-is-the-right-place-to-put-keyrings-for-repositories

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    echo Adding GPG key…
    curl -q https://download.sublimetext.com/sublimehq-pub.gpg \
        | gpg --dearmor \
        | sudo tee /etc/apt/keyrings/sublime-text.gpg > /dev/null

    echo Adding repository…
    file=/etc/apt/sources.list.d/sublime-text.list
    echo -n "deb [arch=amd64 signed-by=/etc/apt/keyrings/sublime-text.gpg]" \
        | sudo tee $file
    echo " https://download.sublimetext.com/ apt/stable/" \
        | sudo tee -a $file

    echo Installing Sublime Text…
    sudo apt update
    sudo apt install -y sublime-text

    echo Done!
else
    echo Could not install Sublime Text >&2
    exit 1
fi

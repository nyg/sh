#!/usr/bin/env sh

# https://launchpad.net/~mattrose
# https://www.digitalocean.com/community/tutorials/how-to-handle-apt-key-and-add-apt-repository-deprecation-using-gpg-to-add-external-repositories-on-ubuntu-22-04
# https://unix.stackexchange.com/a/717955
# https://askubuntu.com/a/1307181
# https://manpages.ubuntu.com/manpages/jammy/en/man8/apt-key.8.html

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    read -p "Use proxy? (if not, leave empty) " proxy_url
    proxy_opts=""
    if [ ! -z proxy_url ]
    then
        proxy_opts="http-proxy=$proxy_url"
    fi

    echo Adding GPG key…
    key=/etc/apt/keyrings/matt-rose-ppa.gpg
    # TODO official way of getting the public key
    # https://github.com/gnome-terminator/terminator/issues/699
    sudo gpg --homedir /tmp \
        --no-default-keyring --keyring $key \
        --keyserver hkp://keyserver.ubuntu.com \
        --keyserver-options "timeout=30 $proxy_opts" \
        --recv-keys BD2FE0A01E3164DB

    echo Adding repository…
    echo "deb [signed-by=$key] https://ppa.launchpadcontent.net/mattrose/terminator/ubuntu/ jammy main" \
        | sudo tee /etc/apt/sources.list.d/terminator.list

    echo Installing Terminator…
    sudo apt update
    sudo apt install -y terminator

    echo Done!
else
    echo Could not install Terminator >&2
    exit 1
fi

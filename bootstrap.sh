#!/usr/bin/env sh
#
# The goal of this script is to clone the repo in $HOME/.$USER-sh.
#
# Usage:
#   curl https://git.sr.ht/~nyg/sh/blob/master/bootstrap.sh | sh
#   wget -q -O - https://git.sr.ht/~nyg/sh/blob/master/bootstrap.sh | sh

set -eu

# Checks if the given software is installed.
is_installed()
{
    which "$1" >/dev/null
}

# Adds user to sudo group if necessary.
add_sudo_group()
{
    if [ "$USER" != root ]
    then
        if groups | grep -v sudo >/dev/null
        then
            echo Adding "$USER" to sudo group, root password required
            su -c usermod - root -aG sudo "$USER"
        fi
    fi
}

#
# Install git if necessary.
if ! is_installed git
then
    echo Installing git…
    OS=$(uname)

    # macOS
    if [ "$OS" = Darwin ]
    then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew install git

    # Linux
    elif [ "$OS" = Linux ]
    then
        if is_installed apt
        then
            if [ -w /var/lib/dpkg/lock-frontend ]
            then
                apt install git
            else
                add_sudo_group
                sudo apt install git
            fi
        fi

    # Unknown
    else
        echo Unknown OS, aborting… >&2
        exit 1
    fi
fi

#
# Clone the repo into `$HOME/.$USER-sh'.
git clone https://git.sr.ht/~nyg/sh "$HOME"/."$USER"-sh

#
# setup the .ssh directory
# echo "Setup .ssh?"
# select yn in "Yes" "No"; do
#     case $yn in
#         Yes )
#             read -p "Input folder whose content must be copied to .ssh:" folder
#             cp "$folder"/* $HOME/.ssh
#             echo Done!
#         No ) exit;;
#     esac
# done

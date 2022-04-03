#!/usr/bin/env sh
#
# The goal of this script is to clone the repo in $HOME/.$USER-sh.
#
# Usage:
#   curl https://git.sr.ht/~nyg/sh/blob/master/bootstrap.sh | sh
#   wget -q -O - https://git.sr.ht/~nyg/sh/blob/master/bootstrap.sh | sh

# checks if the given software is installed
function is_installed() {
    which $1 >/dev/null
    return $?
}

# add user to sudo group if necessary
function add_sudo_group() {
    if [ $USER -ne root ]
    then
        if groups | grep -v sudo >/dev/null
        then
            echo Adding $USER to sudo group
            su -c usermod -aG sudo $USER - root
        fi
    fi
}

#
# Install git if necessary
if is_installed(git)
then
    echo Installing git…

    # macOS
    if [ $(uname) = Darwin ]
    then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew install git

    # Linux
    elif [ $(uname) = Linux ]
        if is_installed(apt)
        then
            if [ -w /var/lib/dpkg/lock-frontend ]
            then
                apt install git
            else
                add_sudo_group()
                sudo apt install git
            fi
        fi
    fi
fi

#
# Clone the repo into $HOME/.$USER-sh
git clone https://git.sr.ht/~nyg/sh "$HOME"/.$USER-sh

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

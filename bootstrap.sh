#!/usr/bin/env sh
#
# The goal of this script is to clone the repo in $HOME/.$USER-sh.
#
# Usage:
#   sh <(curl -s https://git.sr.ht/~nyg/sh/blob/master/bootstrap.sh)
#   sh <(wget -q -O - https://git.sr.ht/~nyg/sh/blob/master/bootstrap.sh)

set -eu

# Checks if the given software is installed.
is_installed()
{
    which "$1" >/dev/null
}


#
# Install git if necessary.
# Note: on macOS, the git command is present but calling it will prompt a GUI to
#       install the Command Line Tools. Installing brew will do that in a silent
#       manner.

OS=$(uname)

# macOS
if [ "$OS" = Darwin ]
then
    echo Installing brew…
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo Installing git…
    brew install git

    echo Done!

# other OSes
elif ! is_installed git
then
    if [ "$OS" = Linux ]
    then
        if is_installed apt
        then
            echo Installing git…

            if groups | grep -qw sudo
            then
                sudo apt update && sudo apt install -y git
            else
                su -l root -c "apt update && apt install -y git"
            fi

            echo Done!
        else
            echo Unknown package manager, aborting… >&2
            exit 1
        fi
    else
        echo Unknown OS, aborting… >&2
        exit 1
    fi
else
    echo Git is installed
fi

#
# Clone the repo into `$HOME/.$USER-sh'.
git clone https://git.sr.ht/~nyg/sh "$HOME"/."$USER"-sh

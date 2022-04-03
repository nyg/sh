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
            echo Adding "$USER" to sudo group
            su -c usermod -aG sudo "$USER" - root
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

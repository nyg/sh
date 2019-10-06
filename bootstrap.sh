#!/usr/bin/env sh

#
# Step 1: setup the .ssh directory

echo "Setup .ssh?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            read -p "Input folder whose content must be copied to .ssh:" folder
            cp "$folder"/* $HOME/.ssh
            echo Done!
        No ) exit;;
    esac
done

#
# Step 2: install git

OS=`uname`

if [ $OS = Darwin ]
then
    # install brew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    
    # install git
    brew install git
fi

#
# Step 3: clone repo into .nyg-sh and run the install script

git clone git@gitlab.com-nyg:nyg/sh.git "$HOME"/.nyg-sh
.nyg-sh/install/install.sh

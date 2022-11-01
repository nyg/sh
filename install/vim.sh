#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_installed vim
then
    echo Vim is already installed.
    exit 0
fi

echo Installing vim…

if is_os Darwin
then
    brew install vim
elif is_os Linux && is_installed apt
then
    sudo apt update
    sudo apt install -y vim
else
    echo Could not install vim >&2
    exit 1
fi

echo Setting up vim configuration files…
mkdir -p "$HOME/.vim"
ln -s "$HOME/.$USER-sh/config/vimrc" "$HOME/.vim/vimrc"

echo Done!

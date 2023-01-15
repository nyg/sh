#!/usr/bin/env sh

set -eu

echo Setting up vim configuration files…

mkdir -p "$HOME/.vim"
ln -s "$HOME/.$USER-sh/etc/vim/vimrc" "$HOME/.vim/vimrc"

ln -s "$HOME/.$USER-sh/etc/vim/vimenv.sh" "$HOME/.$USER-sh/etc/sh/vimenv.sh"

echo Done!

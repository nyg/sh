#!/usr/bin/env sh

set -eu

echo Setting up vim configuration files…
mkdir -p "$HOME/.vim"
ln -s "$HOME/.$USER-sh/etc/vimrc" "$HOME/.vim/vimrc"

echo Done!

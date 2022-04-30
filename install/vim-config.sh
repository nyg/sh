#!/usr/bin/env sh

set -eu

mkdir $HOME/.vim
ln -s $HOME/.$USER-sh/config/vim $HOME/.vim/vimrc

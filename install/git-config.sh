#!/usr/bin/env sh

set -eu

mkdir -p $HOME/.config/git
ln -s $HOME/.$USER-sh/config/git $HOME/.config/git/config
ln -s $HOME/.$USER-sh/config/git-global-ignore $HOME/.config/git/global-ignore

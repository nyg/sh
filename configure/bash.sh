#!/usr/bin/env sh

set -eu

echo Linking bashrc configuration file…
rm "$HOME/.bashrc"
ln -s "$HOME/.$USER-sh/config/bashrc" "$HOME/.bashrc"

echo Done!
exec $SHELL -l

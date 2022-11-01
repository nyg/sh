#!/usr/bin/env sh

set -eu

echo Linking bashrc configuration file…
ln -s "$HOME/.$USER-sh/config/bashrc" "$HOME/.bashrc"

echo Done!

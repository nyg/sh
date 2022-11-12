#!/usr/bin/env sh

set -eu

echo Setting up git configuration files…
mkdir -p "$HOME/.config/git"
ln -s "$HOME/.$USER-sh/etc/git/config" "$HOME/.config/git/config"
ln -s "$HOME/.$USER-sh/etc/git/global-ignore" "$HOME/.config/git/global-ignore"

echo Done!

#!/usr/bin/env sh

set -eu

echo Setting up ssh configuration files…
mkdir -p "$HOME/.ssh"
ln -s "$HOME/.$USER-sh/etc/ssh" "$HOME/.ssh/config"

echo Done!

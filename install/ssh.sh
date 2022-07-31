#!/usr/bin/env sh

set -eu

mkdir -p "$HOME/.ssh"
ln -s "$HOME/.$USER-sh/config/ssh" "$HOME/.ssh/config"

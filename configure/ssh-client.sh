#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

append_if_exists "$HOME/.ssh/config" "$HOME/.$USER-sh/etc/ssh/config"

echo Linking SSH configuration file…
mkdir -p "$HOME/.ssh"
ln -s "$HOME/.$USER-sh/etc/ssh/config" "$HOME/.ssh/config"

echo Done!

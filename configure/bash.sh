#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

echo Backup existing files…
backup_if_exists "$HOME"/.{profile,bash_profile,bashrc,inputrc,bash_login,bash_logout}

echo Linking configuration file…
ln -s "$HOME/.$USER-sh/etc/sh/profile" "$HOME/.profile"
ln -s "$HOME/.$USER-sh/etc/bash/bashrc" "$HOME/.bashrc"
ln -s "$HOME/.$USER-sh/etc/bash/inputrc" "$HOME/.inputrc"

echo Done!
exec $SHELL -l

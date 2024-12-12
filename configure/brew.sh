#!/usr/bin/env sh

set -eu

echo Linking brew init file…
ln -s "$HOME/.$USER-sh/etc/brew/init.sh" "$HOME/.$USER-sh/etc/sh/profile.d/brew.sh"

echo Done!

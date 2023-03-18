#!/usr/bin/env sh

set -eu

echo Linking profile configuration file…
ln -s "$HOME/.$USER-sh/etc/sh/profile" "$HOME/.profile"

echo Done!

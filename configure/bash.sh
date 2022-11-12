#!/usr/bin/env sh

set -eu

echo Linking configuration file…
rm -f "$HOME/.profile" "$HOME/.bashrc" "$HOME/.inputrc"
ln -s "$HOME/.$USER-sh/etc/profile" "$HOME/.profile"
ln -s "$HOME/.$USER-sh/etc/bash/bashrc" "$HOME/.bashrc"
ln -s "$HOME/.$USER-sh/etc/bash/inputrc" "$HOME/.inputrc"

echo Done!
exec $SHELL -l

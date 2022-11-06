#!/usr/bin/env sh

set -eu

echo Linking configuration file…
rm -f "$HOME/.profile" "$HOME/.bashrc" "$HOME/.inputrc"
ln -s "$HOME/.$USER-sh/config/profile" "$HOME/.profile"
ln -s "$HOME/.$USER-sh/config/bashrc" "$HOME/.bashrc"
ln -s "$HOME/.$USER-sh/config/inputrc" "$HOME/.inputrc"

echo Done!
exec $SHELL -l

#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

backup_if_exists "${ZDOTDIR:-$HOME}"/.{zshenv,zprofile,zshrc,zlogin,zlogout}

ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
echo ZDOTDIR is set to \'$ZDOTDIR\', creating directory…
mkdir -p "$ZDOTDIR"

echo Linking zsh configuration files…
ln -s "$HOME/.$USER-sh/etc/zsh/zshenv" "$HOME/.zshenv"
ln -s "$HOME/.$USER-sh/etc/zsh/zshenv_zdotdir" "$ZDOTDIR/.zshenv"
ln -s "$HOME/.$USER-sh/etc/zsh/zprofile" "$ZDOTDIR/.zprofile"
ln -s "$HOME/.$USER-sh/etc/zsh/zshrc" "$ZDOTDIR/.zshrc"

echo Done! Run ./configure/profile.sh if on Linux and not using Wayland.
echo exec\'ing new login shell now…
exec $SHELL -l

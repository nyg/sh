#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

backup_if_exists "${ZDOTDIR:-$HOME}"/.{zshenv,zprofile,zshrc,zlogin,zlogout}

ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"
echo ZDOTDIR is set to \'$ZDOTDIR\', creating directory…
mkdir -p "$ZDOTDIR"

if ! grep 'ZDOTDIR=' /etc/zshenv >/dev/null 2>&1
then
    echo Appending ZDOTDIR to /etc/zshenv…
    echo 'export ZDOTDIR="$HOME/.config/zsh"' | sudo tee -a /etc/zshenv
fi

echo Linking zsh configuration files…
ln -s "$HOME/.$USER-sh/etc/zsh/zshenv" "$ZDOTDIR/.zshenv"
ln -s "$HOME/.$USER-sh/etc/zsh/zprofile" "$ZDOTDIR/.zprofile"
ln -s "$HOME/.$USER-sh/etc/zsh/zshrc" "$ZDOTDIR/.zshrc"

echo Done!
echo exec\'ing new login shell now…
exec $SHELL -l

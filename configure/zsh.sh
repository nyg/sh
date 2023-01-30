#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

backup_if_exists zsh "${ZDOTDIR:-$HOME}"/.{zshenv,zprofile,zshrc,zlogin,zlogout}

# source zshenv to avoid hardcoding ZDOTDIR
. "$HOME/.$USER-sh/etc/zsh/zshenv"

mkdir -p "${ZDOTDIR}"
ln -s "$HOME/.$USER-sh/etc/zsh/zshenv" "${ZDOTDIR:-$HOME}/.zshenv"
ln -s "$HOME/.$USER-sh/etc/zsh/zprofile" "${ZDOTDIR:-$HOME}/.zprofile"
ln -s "$HOME/.$USER-sh/etc/zsh/zshrc" "${ZDOTDIR:-$HOME}/.zshrc"

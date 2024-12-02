#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

append_if_exists "$HOME/.vimrc" "$HOME/.$USER-sh/etc/vim/vimrc"
append_if_exists "$HOME/.vim/vimrc" "$HOME/.$USER-sh/etc/vim/vimrc"

echo Linking vim configuration files…
mkdir -p "$XDG_CONFIG_HOME/vim" "$XDG_CACHE_HOME/vim"
ln -s "$HOME/.$USER-sh/etc/vim/vimrc" "$XDG_CONFIG_HOME/vim/vimrc"
ln -s "$HOME/.$USER-sh/etc/vim/vimenv.sh" "$HOME/.$USER-sh/etc/sh/rc.d/vimenv.sh"

echo exec\'ing new shell now…
exec $SHELL

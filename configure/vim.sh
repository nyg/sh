#!/usr/bin/env sh
# TODO https://tlvince.com/vim-respect-xdg

set -eu

. "$HOME/.$USER-sh/common.sh"

append_if_exists "$HOME/.vimrc" "$HOME/.$USER-sh/etc/vim/vimrc"
append_if_exists "$HOME/.vim/vimrc" "$HOME/.$USER-sh/etc/vim/vimrc"

echo Linking vim configuration files…
mkdir -p "$HOME/.config/vim"
ln -s "$HOME/.$USER-sh/etc/vim/vimrc" "$HOME/.config/vim/vimrc"
ln -s "$HOME/.$USER-sh/etc/vim/vimenv.sh" "$HOME/.$USER-sh/etc/sh/rc.d/vimenv.sh"

. "$HOME/.$USER-sh/etc/vim/vimenv.sh"
echo Done, make sure VIMINIT is exported and set to \'$VIMINIT\'.

echo exec\'ing new shell now…
exec $SHELL

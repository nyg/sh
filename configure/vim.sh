#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if [ "${VIM_HOME-}" ]
then
    append_if_exists "$VIM_HOME/vimrc" "$HOME/.$USER-sh/etc/vim/vimrc"
fi

append_if_exists "$HOME/.vimrc" "$HOME/.$USER-sh/etc/vim/vimrc"

. "$HOME/.$USER-sh/etc/vim/vimenv.sh"

echo Linking vim configuration files…
mkdir -p "$VIM_HOME"
ln -s "$HOME/.$USER-sh/etc/vim/vimrc" "$VIM_HOME/vimrc"
ln -s "$HOME/.$USER-sh/etc/vim/vimenv.sh" "$HOME/.$USER-sh/etc/sh/vimenv.sh"

echo Done, make sure VIM_HOME is correctly set to $VIM_HOME!

echo exec\'ing new shell now…
exec $SHELL

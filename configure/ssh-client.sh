#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if [ -r "$HOME/.ssh/config" ]
then
    echo Using existing SSH config file to replace etc/git/config…
    temp_file=$(mktemp /tmp/gitconfig.XXXXXX)
    cat "$HOME/.ssh/config" > "$temp_file"
    rm "$HOME/.ssh/config"
    cat "$temp_file" > "$HOME/.$USER-sh/etc/ssh/config"
fi

echo Linking SSH configuration file…
mkdir -p "$HOME/.ssh"
ln -s "$HOME/.$USER-sh/etc/ssh/config" "$HOME/.ssh/config"

echo Done!

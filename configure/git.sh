#!/usr/bin/env sh

set -eu

echo Setting up git configuration files…
mkdir -p "$HOME/.config/git"
ln -s "$HOME/.$USER-sh/etc/git/config" "$HOME/.config/git/config"
ln -s "$HOME/.$USER-sh/etc/git/global-ignore" "$HOME/.config/git/global-ignore"

if [ -r "$HOME/.gitconfig" ]
then
    echo Moving existing config…
    cat "$HOME/.gitconfig" >> "$HOME/.config/git/config"
    rm "$HOME/.gitconfig"
fi

read -p "Value for user.name (empty to skip) " username
[ ! -z "$username" ] && git config --global user.name "$username"

read -p "Value for user.email (empty to skip) " email
[ ! -z "$email" ] && git config --global user.email "$email"

echo Done!

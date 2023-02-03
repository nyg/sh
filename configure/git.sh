#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

append_if_exists "$HOME/.gitconfig" "$HOME/.$USER-sh/etc/git/config"
append_if_exists "$HOME/.config/git/config" "$HOME/.$USER-sh/etc/git/config"
backup_if_exists "$HOME/.config/git/global-ignore"

echo Linking git configuration files…
create_if_not_exists "$HOME/.config/git"
ln -s "$HOME/.$USER-sh/etc/git/config" "$HOME/.config/git/config"
ln -s "$HOME/.$USER-sh/etc/git/global-ignore" "$HOME/.config/git/global-ignore"

read -p "Value for user.name (empty to skip) " username
[ ! -z "$username" ] && git config --global user.name "$username"

read -p "Value for user.email (empty to skip) " email
[ ! -z "$email" ] && git config --global user.email "$email"

echo Done!

#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

export NVM_DIR="$HOME/.config/nvm"

echo Cloning nvm…
git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"

last_tag=$(git -P -C $NVM_DIR tag --sort=taggerdate | tail -1)
git -C $NVM_DIR -c advice.detachedHead=false co $last_tag

echo Loading nvm…
. "$NVM_DIR/nvm.sh"

echo Installing latest LTS node version…
nvm install --lts

echo Linking npmrc configuration file…
append_if_exists "$HOME/.npmrc" "$HOME/.$USER-sh/etc/npm/npmrc"
ln -s "$HOME/.$USER-sh/etc/npm/npmrc" "$HOME/.npmrc"

echo Linking nvm configuration file…
ln -s "$HOME/.$USER-sh/etc/nvm/profile" "$HOME/.$USER-sh/etc/sh/profile.d/nvm.sh"

echo Done!
exec $SHELL -l

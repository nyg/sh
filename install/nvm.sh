#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

export NVM_DIR="$XDG_DATA_HOME/nvm"

echo Cloning nvm…
git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"

last_tag=$(git -P -C $NVM_DIR tag --sort=taggerdate | tail -1)
git -C $NVM_DIR -c advice.detachedHead=false co $last_tag

echo Loading nvm…
. "$NVM_DIR/nvm.sh"

echo Installing latest LTS node version…
nvm install --lts

echo Installing pnpm…
npm install -g pnpm

echo Linking npmrc configuration file…
append_if_exists "$HOME/.npmrc" "$HOME/.$USER-sh/etc/npm/npmrc"
ln -s "$HOME/.$USER-sh/etc/npm/npmrc" "${NPM_CONFIG_USERCONFIG:-$HOME/.npmrc}"

echo Linking nvm configuration file…
ln -s "$HOME/.$USER-sh/etc/nvm/rc" "$HOME/.$USER-sh/etc/sh/rc.d/nvm.sh"

echo Done!
exec $SHELL -l

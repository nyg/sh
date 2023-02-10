#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

export NVM_DIR="$HOME/.config/nvm"

if is_os Darwin
then
    echo Installing nvm…
    brew install nvm

elif is_os Linux
then
    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"

    last_tag=$(git -P -C $NVM_DIR tag --sort=taggerdate | tail -1)
    git -C $NVM_DIR -c advice.detachedHead=false co $last_tag

else
    echo Could not install nvm >&2
    exit 1
fi

echo Loading nvm…
. "$NVM_DIR/nvm.sh"

echo Installing latest node version…
nvm install node

echo Linking npmrc configuration file…
[ -r "$HOME/.npmrc" ] && cat "$HOME/.npmrc" "$HOME/.$USER-sh/etc/npm/npmrc" > "$HOME/.$USER-sh/etc/npm/npmrc"
backup_if_exists "$HOME/.npmrc"
ln -s "$HOME/.$USER-sh/etc/npm/npmrc" "$HOME/.npmrc"

echo Linking nvm/init.sh…
ln -s "$HOME/.$USER-sh/etc/nvm/init.sh" "$HOME/.$USER-sh/etc/sh/profile.d/nvm.sh"

echo Done!
exec $SHELL -l

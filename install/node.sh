#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

echo Installing nvm…

if is_installed wget
then
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
elif is_installed curl
then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
else
    echo Could not install nvm >&2
    exit 1
fi

echo Loading nvm…
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

echo Installing latest node version…
nvm install node

ln -s "$HOME/.$USER-sh/config/npmrc" "$HOME/.npmrc"

echo Done!

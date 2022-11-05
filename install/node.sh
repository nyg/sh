#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Darwin
then
    echo Installing nvm…
    brew install nvm
elif is_os Linux
then
    echo Fetching tag name of latest version…
    latest=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest \
        | jq -r .tag_name)

    echo Installing nvm ${latest}…
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$latest/install.sh | bash
else
    echo Could not install nvm >&2
    exit 1
fi

echo Loading nvm…
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

echo Installing latest node version…
nvm install node

echo Linking npmrc configuration file…
ln -s "$HOME/.$USER-sh/config/npmrc" "$HOME/.npmrc"

echo Done!
exec $SHELL -l

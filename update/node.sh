#!/usr/bin/env sh

# nvm is a function and therefore cannot be made available to sh from the shell
# sourcing this script
. "$NVM_DIR/nvm.sh"

set -e

echo Installing node latest version…
current_version=$(nvm version)
nvm install node --reinstall-packages-from=$current_version
nvm use node

echo Removing node ${current_version}…
nvm uninstall $current_version

echo Updating pnpm…
npm update -g pnpm

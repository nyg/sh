#!/usr/bin/env sh

# nvm is a function and therefore cannot be made available to sh from the shell
# sourcing this script
. "$NVM_DIR/nvm.sh"

set -e

# upgrade node to latest lts
current_version=$(nvm version)
nvm install node --reinstall-packages-from=$current_version
nvm uninstall $current_version

# update pnpm
npm update -g pnpm

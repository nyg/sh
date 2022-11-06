#!/usr/bin/env sh

# nvm is a function and therefore cannot be made available to sh from the shell
# sourcing this script
. "$NVM_DIR/nvm.sh"

set -e

current_version=$(nvm version)
nvm install node --reinstall-packages-from=$current_version
nvm uninstall $current_version

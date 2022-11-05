#!/usr/bin/env sh

set -eu

current_version=$(nvm version)
nvm install node --reinstall-packages-from=$current_version
nvm uninstall $current_version

# TODO doesn't work in sh

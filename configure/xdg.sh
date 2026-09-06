#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/etc/sh/profile"

echo Creating XDG base directories…
mkdir -p "$XDG_CACHE_HOME" \
         "$XDG_CONFIG_HOME" \
         "$XDG_DATA_HOME" \
         "$XDG_STATE_HOME"

echo Creating directories for softwares which do not create their own…
mkdir -p "$XDG_CONFIG_HOME/npm" \
         "$XDG_CONFIG_HOME/pnpm" \
         "$XDG_STATE_HOME/less" \
         "$XDG_STATE_HOME/node"

echo Done!

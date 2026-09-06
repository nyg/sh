#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    echo Updating gitdeck…
    cd "$HOME/.local/opt/gitdeck"
    git pull --ff-only
    pnpm install
    pnpm run build

    echo Restarting gitdeck.service…
    systemctl --user restart gitdeck
    systemctl --user --no-pager status gitdeck

    echo Done!
else
    echo Unsupported OS >&2
    exit 1
fi

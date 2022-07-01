#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    # visudo & sudoedit https://unix.stackexchange.com/a/27595

    echo Installing sudo…
    su -l root -c "apt update && apt install -y sudo visudo sudoedit"

    echo Adding "$USER" to sudo group…
    su -l root -c "usermod -aG sudo $USER"

else
    echo Could not install curl >&2
    exit 1
fi

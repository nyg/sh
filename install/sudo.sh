#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    # setting up sudo https://unix.stackexchange.com/a/425664
    # visudo & sudoedit https://unix.stackexchange.com/a/27595

    echo Installing sudo…
    su -l root -c "apt update && apt install -y sudo"

    echo Adding "$USER" to sudo group…
    su -l root -c "usermod -aG sudo $USER"

    echo Done, need to log out now!
else
    echo Could not install sudo >&2
    exit 1
fi

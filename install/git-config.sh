#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if ! is_installed git
then
    echo Installing git…

    if is_os Darwin
    then
        brew install git
    elif is_os Linux && is_installed apt
    then
        sudo apt update
        sudo apt install -y git
    else
        echo Could not install git >&2
        exit 1
    fi
else
    echo Git was already installed.
fi

echo Setting up configuration files…
mkdir -p "$HOME/.config/git"
ln -s "$HOME/.$USER-sh/config/git" "$HOME/.config/git/config"
ln -s "$HOME/.$USER-sh/config/git-global-ignore" "$HOME/.config/git/global-ignore"

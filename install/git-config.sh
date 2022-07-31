#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_installed git
then
    echo Git is already installed.
    exit 0
fi

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

mkdir -p "$HOME/.config/git"
ln -s "$HOME/.$USER-sh/config/git" "$HOME/.config/git/config"
ln -s "$HOME/.$USER-sh/config/git-global-ignore" "$HOME/.config/git/global-ignore"

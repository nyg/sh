#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Darwin
then
    brew install curl
elif is_os Linux && is_installed apt
then
    sudo apt update
    sudo apt install -y curl
else
    echo Could not install curl >&2
    exit 1
fi

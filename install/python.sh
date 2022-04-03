#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Darwin
then
    echo Installing dependencies…
    xcode-select --install
    brew install pyenv openssl readline sqlite3 xz zlib
elif is_os Linux && is_installed apt
then
    echo Installing dependencies…
    sudo apt update
    sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev  \
                        libreadline-dev libsqlite3-dev wget curl llvm          \
                        libncursesw5-dev xz-utils tk-dev libxml2-dev           \
                        libxmlsec1-dev libffi-dev liblzma-dev

    echo Sourcing pyenv env vars…
    . "$HOME/.$USER-sh/config/pyenv.sh"

    echo Installing curl…
    . "$HOME/.$USER-sh/install/curl.sh"
    curl https://pyenv.run | bash

    for v in 2 3 ; do
        echo Installing version $v
        last_version=$(pyenv install -l | grep "^\s*$v\.\d*\.\d*$"| tail -1)
        pyenv install $last_version
    done

    pyenv rehash
    pyenv global $last_version
else
    echo Could not install python >&2
    exit 1
fi

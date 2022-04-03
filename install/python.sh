#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Darwin
then
    xcode-select --install
    brew install pyenv openssl readline sqlite3 xz zlib
elif is_os Linux && is_installed apt
then
    sudo apt update
    sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev  \
                        libreadline-dev libsqlite3-dev wget curl llvm          \
                        libncursesw5-dev xz-utils tk-dev libxml2-dev           \
                        libxmlsec1-dev libffi-dev liblzma-dev

    . "$HOME/.$USER-sh/config/pyenv.sh"

    . "$HOME/.$USER-sh/install/curl.sh"
    curl https://pyenv.run | bash

    # install latest python 2 and 3 versions
    for v in 2 3 ; do
        last_version=$(pyenv install -l | grep "^\s*$v\.\d\.\d$" | tail -1)
        pyenv install $last_version
        pyenv rehash
    done

    # sets python 3 as global version
    pyenv global $last_version
else
    echo Could not install python >&2
    exit 1
fi

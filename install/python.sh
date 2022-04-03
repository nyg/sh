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

    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"

    echo Installing curl…
    . "$HOME/.$USER-sh/install/curl.sh"

    echo Installing pyenv…
    curl https://pyenv.run | bash

    echo Setting up pyenv…
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"

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

#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if is_os Darwin
then
    echo Installing pyenv…
    brew install pyenv

elif is_os Linux && is_installed apt
then
    echo Installing dependencies…
    sudo apt update
    sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev  \
                        libreadline-dev libsqlite3-dev wget curl llvm          \
                        libncursesw5-dev xz-utils tk-dev libxml2-dev           \
                        libxmlsec1-dev libffi-dev liblzma-dev

    echo Installing pyenv…
    curl https://pyenv.run | bash
else
    echo Could not install python >&2
    exit 1
fi

echo Setting up pyenv shims path…
eval "$(pyenv init --path)"
echo Init pyenv…
eval "$(pyenv init -)"

for v in 2 3
do
    if is_os Darwin
    then
        last_version=$(pyenv install -l | grep -e "^\s*$v\.\d*\.\d*$" | tail -1 | sed 's/ *//')
    else
        last_version=$(pyenv install -l | grep -P "^\s*$v\.\d*\.\d*$" | tail -1 | sed 's/ *//')
    fi

    echo Installing version ${last_version}…
    pyenv install $last_version
done

echo Setting the last version as the global one…
pyenv rehash
pyenv global $last_version

echo Linking pyenv.sh to config/sh/pyenv.sh…
ln -s "$HOME/.$USER-sh/config/pyenv.sh" "$HOME/.$USER-sh/config/sh/pyenv.sh"

echo Done!
exec $SHELL -l

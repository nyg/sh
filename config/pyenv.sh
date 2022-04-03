#!/usr/bin/env sh

set -eu

export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"

eval "$(pyenv init --path)"
eval "$(pyenv init -)"

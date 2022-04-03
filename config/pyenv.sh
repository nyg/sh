#!/usr/bin/env sh

. "$HOME/.$USER-sh/common.sh"

export PYENV_ROOT="$HOME/.pyenv"

# add PYENV_ROOT/bin to PATH, not necessary for macOS if installed with brew
export PATH="$PYENV_ROOT/bin:$PATH"

if is_installed pyenv
then
    # add pyenv shims to the path
    eval "$(pyenv init --path)"

    # Init pyenv (shell completion, etc.)
    eval "$(pyenv init -)"
fi

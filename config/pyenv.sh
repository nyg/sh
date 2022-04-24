#!/usr/bin/env sh

# probably not needed if installed with brew
export PYENV_ROOT="$HOME/.pyenv"

# add PYENV_ROOT/bin to PATH, not necessary for macOS if installed with brew
if [ -d $PYENV_ROOT/bin ]
then
    export PATH="$PYENV_ROOT/bin:$PATH"
fi

# add pyenv shims to the path
eval "$(pyenv init --path)"

# init pyenv (shell completion, etc.)
eval "$(pyenv init -)"

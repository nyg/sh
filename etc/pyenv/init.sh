if [ "$(uname)" != Darwin ]
then
    export PYENV_ROOT="$HOME/.pyenv"
    PATH="$PATH:$PYENV_ROOT/bin"
fi

# add pyenv shims to the path
eval "$(pyenv init --path)"

# init pyenv (shell completion, etc.)
#eval "$(pyenv init -)"

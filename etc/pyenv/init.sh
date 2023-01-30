# TODO not needed for macOS if installed with brew
export PYENV_ROOT="$HOME/.pyenv"
[ -d $PYENV_ROOT/bin ] && PATH="$PATH:$PYENV_ROOT/bin"

# add pyenv shims to the path
eval "$(pyenv init --path)"

# init pyenv (shell completion, etc.)
eval "$(pyenv init -)"

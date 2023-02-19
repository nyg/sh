export PYENV_ROOT="$HOME/.config/pyenv"

# On macOS pyenv is installed via brew so its binaries are already in the path.
if [ "$(uname)" != Darwin ]
then
    PATH="$PATH:$PYENV_ROOT/bin"
fi

PATH="$PYENV_ROOT/shims:$PATH"

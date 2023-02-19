export PYENV_ROOT="$HOME/.config/pyenv"

# On macOS pyenv is installed via brew so pyenv binaries are alreadying in the
# path, on other OSes that won't be the case.
if [ "$(uname)" != Darwin ]
then
    PATH="$PATH:$PYENV_ROOT/bin"
fi

PATH="$PYENV_ROOT/shims:$PATH"

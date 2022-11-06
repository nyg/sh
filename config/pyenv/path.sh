# probably not needed if installed with brew
export PYENV_ROOT="$HOME/.pyenv"

# add PYENV_ROOT/bin to PATH, not necessary for macOS if installed with brew
[ -d $PYENV_ROOT/bin ] && export PATH="$PYENV_ROOT/bin:$PATH"

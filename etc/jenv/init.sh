export JENV_ROOT="$HOME/.config/jenv"

# On macOS jenv is installed via brew so its binaries are already in the path.
if [ "$(uname)" != Darwin ]
then
    PATH="$PATH:$JENV_ROOT/bin"
fi

zsh-defer eval "$(jenv init - --no-rehash | grep -v completions)"

# macOS
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi

[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.$USER-sh/bin" ] && export PATH="$HOME/.$USER-sh/bin:$PATH"

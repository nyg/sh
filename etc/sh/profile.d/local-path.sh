# add .local/bin and .$USER-sh/bin to PATH
[ -d "$HOME/.local/bin" ] && PATH="$PATH:$HOME/.local/bin"
[ -d "$HOME/.$USER-sh/bin" ] && PATH="$PATH:$HOME/.$USER-sh/bin"

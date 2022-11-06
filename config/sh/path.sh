[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.$USER-sh/scripts" ] && PATH="$HOME/.$USER-sh/scripts:$PATH"

# TODO: Added by Toolbox App
export PATH="$PATH:/home/user/.local/share/JetBrains/Toolbox/scripts"

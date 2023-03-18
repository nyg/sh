add_to_path() {
    [ ! -d "$1" ] && return
    echo $PATH | grep "$1" > /dev/null && return
    PATH="$PATH:$1"
}

# add .local/bin and .$USER-sh/bin to PATH
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/.$USER-sh/bin"

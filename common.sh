# Checks if the given software is installed.
is_installed()
{
    which "$1" >/dev/null
}

# Checks the OS.
is_os()
{
    [ "$(uname)" = "$1" ]
}

# Move given files inside the .$USER-sh/backup/$1 directory, if said files exist.
backup_if_exists()
{
    bck_dir="$HOME/.$USER-sh/backup/zsh"
    mkdir -p $bck_dir

    shift

    for f in "$@"
    do
        if [ -f "$f" ]
        then
            echo Moving "$f" to "$bck_dir"/
            mv "$f" "$bck_dir"
        fi
    done
}

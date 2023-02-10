# Prints line which caused the error.
err_report()
{
    echo Error on line $(caller): \'$1\'
}

trap 'err_report "$BASH_COMMAND"' ERR

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

# Moves any existing of $@ to directory .$USER-sh/backup.
backup_if_exists()
{
    bck_dir="$HOME/.$USER-sh/backup"
    mkdir -p "$bck_dir"

    for f in "$@"
    do
        if [ -w "$f" ]
        then
            temp_file=$(mktemp /tmp/XXXXXX)
            bck_file=$(basename "$f").$(basename "$temp_file")

            echo Moving "$f" to "$bck_dir/$bck_file"
            cat "$f" > "$temp_file"
            rm "$f"
            cat "$temp_file" > "$bck_dir/$bck_file"
        fi
    done
}

# Appends a file to another and backs up the former.
append_if_exists()
{
    if [ ! -f "$1" ]
    then
        return
    fi

    if [ -w "$1" ] && [ -w "$2" ]
    then
        echo Found $1, appending to $2
        temp_file=$(mktemp /tmp/XXXXXX)
        cat "$1" > "$temp_file"
        backup_if_exists "$1"
        cat "$temp_file" >> "$2"
    else
        echo $1 or $2 is not writable >&2
        return 1
    fi
}

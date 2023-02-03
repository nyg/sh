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

# Creates directory if it does not already exists.
create_if_not_exists()
{
    [ ! -d "$1" ] && mkdir "$1"
}

# Moves any existing of $@ to directory .$USER-sh/backup.
backup_if_exists()
{
    bck_dir="$HOME/.$USER-sh/backup"
    create_if_not_exists "$bck_dir"

    for f in "$@"
    do
        if [ -w "$f" ]
        then
            bck_file=$(mktemp $(basename "$f").XXXXXX)
            rm "$bck_file"

            echo Moving "$f" to "$bck_dir/$bck_file"
            mv "$f" "$bck_dir/$bck_file"
        fi
    done
}

# Appends a file to another and backs up the former.
append_if_exists()
{
    if [ -w "$1" ] && [ -w "$2"]
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

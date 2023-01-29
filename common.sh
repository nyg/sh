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

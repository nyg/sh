#!/usr/bin/env sh

# Checks if the given software is installed.
is_installed()
{
    which "$1" >/dev/null
}

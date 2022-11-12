#!/usr/bin/env zsh

# exit when any of the commands fails
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "\"${last_command}\" command finished with exit code $?."' EXIT

# create temp dir
dir=/tmp/$(date +%s)
mkdir $dir
cd $dir

# dl audio only
youtube-dl -x --audio-format m4a --audio-quality 0 $1

# move file to iTunes, uh, I mean Music
mv * ~/Music/Music/Media/Automatically\ Add\ to\ Music.localized/

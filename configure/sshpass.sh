#!/usr/bin/env sh

set -eu

printf "Input password to be used for sshpass: "
trap 'stty echo' INT EXIT
stty -echo
read password
printf "\n"

sshp_dir="$HOME/.config/sshpass"
mkdir -p "$sshp_dir"

echo "$password" | gpg --personal-cipher-preferences AES256 -c -o $sshp_dir/password.gpg

echo Done!

# reload aliases.sh
echo exec\'ing new shell now…
exec $SHELL

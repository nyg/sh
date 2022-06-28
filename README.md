# sh

## Bootstrap

Will clone this repo in `$HOME/.$USER-sh`.

```sh
# macOS
sh <(curl -s https://git.sr.ht/~nyg/sh/blob/master/bootstrap.sh)

# Debian
sh <(wget -q -O - https://git.sr.ht/~nyg/sh/blob/master/bootstrap.sh)
```

## TODO

```
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export ICL="$HOME/Library/Mobile Documents/com~apple~CloudDocs/"
export PATH=$HOME/.$USER-sh/bin:$PATH

Files are divided in three categories:

* **install** files, which will install software as well as create symbolic links for eventual config files
* **config** files, as mentioned aboved
* **env** files which usually modify env variables or need to be executed each time a new shell starts.

# Adds user to sudo group if necessary.
# add_sudo_group()
# {
#     if [ "$USER" != root ]
#     then
#         if groups | grep -v sudo >/dev/null
#         then
#             echo Adding "$USER" to sudo group, root password required
#             su -l root -c "usermod -aG sudo $USER"
#             echo Please log out for the change to take effect
#             exit 0
#         fi
#     fi
# }

#
# setup the .ssh directory
# echo "Setup .ssh?"
# select yn in "Yes" "No"; do
#     case $yn in
#         Yes )
#             read -p "Input folder whose content must be copied to .ssh:" folder
#             cp "$folder"/* $HOME/.ssh
#             echo Done!
#         No ) exit;;
#     esac
# done
```

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
On Debian, add /usr/sbin to path to get visudo.

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export ICL="$HOME/Library/Mobile Documents/com~apple~CloudDocs/"
export PATH=$HOME/.$USER-sh/bin:$PATH

Files are divided in three categories:

* **install** files, which will install software as well as create symbolic links for eventual config files
* **config** files, as mentioned aboved
* **env** files which usually modify env variables or need to be executed each time a new shell starts.

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

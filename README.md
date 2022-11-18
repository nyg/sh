# sh

## Bootstrap

```sh
# curl
sh <(curl -s https://git.sr.ht/~nyg/sh/blob/master/bootstrap.sh)

# wget
sh <(wget -q -O - https://git.sr.ht/~nyg/sh/blob/master/bootstrap.sh)
```

This will install `git` and clone this repository in `$HOME/.$USER-sh`.

## Description

Files are divided in multiple folders:

* `etc` configuration files,
* `bin` miscellaneous scripts, directory is added to the path,
* `install` installation scripts, one per software,
* `uninstall` uninstallation scripts,
* `configure` configuration scripts (for softwares that are already installed),
* `update` update scripts for installed softwares,
* `softwares` install location for softwares such as Postman, SQLDeveloper, etc.
* `backup` backup scripts for specific OSes.

## Examples

Examples of post-install flows.

### Ubuntu VM

```sh
sh <(wget -q -O - https://git.sr.ht/~nyg/sh/blob/master/bootstrap.sh)

./configure/bash.sh
./configure/git.sh

apt-update.sh

./install/debian-misc.sh
./configure/vim.sh

./install/ssh-server.sh
# copy git.sr.ht keys from host
#   scp ~/.ssh/git@git.sr.ht* <user>@<ip>:~/.ssh/
# change repo remote url to ssh
#   git remote set-url origin git@git.sr.ht:~nyg/sh

./install/node.sh
./install/python.sh

./install/java.sh
./install/visualvm.sh
./install/jetbrains-toolbox.sh

./install/brave-browser.sh
./install/postman.sh
./install/sqldeveloper.sh
./install/sublime-text.sh
./install/typora.sh
./install/vscodium.sh

./install/zsh.sh
```

## TODO

### Misc

* Move documentation to cs-notes

### ZSH

* fix zcompdump (is compinit invoked twice?)
* histfile
* zshdotdir

### macOS

* `ps -p $$ | cut -d " " -f1 | xargs lsof -p`
* backup: check which config can be added to git and symlinked
* Links
  * https://macos-defaults.com/
  * https://github.com/catilac/plistwatch
* Time Machine
  * Local snapshots: https://support.apple.com/en-us/HT204015
  * `tmutil addexclusion`: useful to exclude .node_modules

```sh
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export ICL="$HOME/Library/Mobile Documents/com~apple~CloudDocs/"
export PATH=$HOME/.$USER-sh/bin:$PATH
export SAGE_ROOT="/usr/local/Caskroom/sage/9.4,1.2.2/SageMath-9-4.app/Contents/Frameworks/Sage.framework/Versions/9.4"
export SAGE_LOCAL="$SAGE_ROOT/local"

if [ "$OS" = 'Darwin' ]
then
    # https://zsh.sourceforge.io/Guide/zshguide02.html#l6
    # https://zsh.sourceforge.io/Doc/Release/zsh_toc.html
    # https://www.softec.lu/site/DevelopersCorner/MasteringThePathHelper
    # https://unix.stackexchange.com/questions/22979/path-helper-and-zsh
    # https://osxdaily.com/2010/05/06/speed-up-a-slow-terminal-by-clearing-log-files/
    # https://github.com/yb66/path_helper
    export PATH=/usr/local/bin:$PATH
fi
```

### Debian

* add `/usr/sbin` to path to get visudo

### Ubuntu 22.04

* Doc for apt key
  * https://askubuntu.com/questions/1286545/what-commands-exactly-should-replace-the-deprecated-apt-key
  * https://www.digitalocean.com/community/tutorials/how-to-handle-apt-key-and-add-apt-repository-deprecation-using-gpg-to-add-external-repositories-on-ubuntu-22-04
  * https://askubuntu.com/questions/1437207/what-is-the-right-place-to-put-keyrings-for-repositories
* gsettings set org.gnome.mutter overlay-key ""
* Default editor
  * https://askubuntu.com/questions/454649/how-can-i-change-the-default-editor-of-the-sudoedit-command-to-be-vim
* Remove update-alternatives

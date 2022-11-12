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

Files are divided in six folders:

* `etc` configuration files,
* `bin` miscellaneous scripts, directory is added to the path,
* `install` installation scripts, one per software,
* `configure` configuration scripts (for softwares that are already installed),
* `update` update scripts for installed softwares.
* `softwares` install location for softwares such as Postman, SQLDeveloper, etc.

## Examples

Post-install flow examples.

### Ubuntu VM

```sh
./install/curl
./bin/apt-update
./install/vim
./install/ssh-server
# copy git.sr.ht keys via scp: `scp ~/.ssh/git@git.sr.ht* <user>@<ip>:~/.ssh/`
./configure/git
# TODO change remote url for repo: git remote set-url origin git@git.sr.ht:~nyg/sh
./configure/bash
./install/node
./install/python
# TODO script fstab shared folders (check todo linux)
./install/java
./install/visualvm # (mbeans plugin can be installed from UI easily, stored in ~/.visualvm)
./install/jetbrains.sh # TODO modifies .profile and creates .profile.bak
```

## TODO

* Move doc to cs-notes
* zsh
  * fix zcompdump (is compinit invoked twice?)
  * histfile
  * zshdotdir

### macOS

* ps -p $$ | cut -d " " -f1 | xargs lsof -p
* backup: check which config can be added to git and symlinked
* use Codium and LibreWolf
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

* On Debian, add /usr/sbin to path to get visudo.

### Ubuntu 22.04

* TODO remove snap?
  * https://onlinux.systems/guides/20220524_how-to-disable-and-remove-snap-on-ubuntu-2204
* Doc
  * https://askubuntu.com/questions/1286545/what-commands-exactly-should-replace-the-deprecated-apt-key
  * https://www.digitalocean.com/community/tutorials/how-to-handle-apt-key-and-add-apt-repository-deprecation-using-gpg-to-add-external-repositories-on-ubuntu-22-04
  * https://askubuntu.com/questions/1437207/what-is-the-right-place-to-put-keyrings-for-repositories
* gsettings set org.gnome.mutter overlay-key ""

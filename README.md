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

* `etc` configuration files, one folder per software,
* `bin` miscellaneous scripts, directory is added to the path,
* `install` installation scripts, one per software,
* `uninstall` uninstallation scripts,
* `configure` configuration scripts (for softwares that are already installed),
* `update` update scripts for installed softwares,
* `softwares` install location for softwares such as Postman, SQLDeveloper, etc.
* `backup` backup scripts for specific OSes.

`common.sh` holds the helpers shared by these scripts.

The shell reads `etc/sh/profile` in login shells, which exports the environment and sources `etc/sh/profile.d/*`. Interactive shells read `etc/bash/bashrc` or `etc/zsh/zshrc`, both sourcing `etc/sh/rc.d/*`, where install scripts symlink the initialization of each software. See [AGENTS.md](AGENTS.md) for the conventions these files follow.

## Examples

Examples of post-install flows.

### Ubuntu VM

```sh
sh <(wget -q -O - https://git.sr.ht/~nyg/sh/blob/master/bootstrap.sh)

./configure/xdg.sh

./configure/zsh.sh
./install/zsh-p10k.sh
./install/zsh-defer.sh # optional (used for nvm)
./configure/profile.sh # if display manager doesn't start a login shell

apt-update.sh

./configure/git.sh

./install/misc-linux-apt.sh
./configure/vim.sh

./install/ssh-server.sh
# copy git.sr.ht keys from host
#   scp ~/.ssh/git@git.sr.ht* <user>@<ip>:~/.ssh/
# change repo remote url to ssh
#   git remote set-url origin git@git.sr.ht:~nyg/sh

./install/nvm.sh
./install/pyenv.sh
./install/jenv.sh

./install/visualvm.sh
./install/jetbrains-toolbox.sh
./install/sqldeveloper.sh

./install/brave-browser.sh
./install/postman.sh
./install/sublime-text.sh
./install/typora.sh
./install/vscodium.sh
```

### Other machines

* [macOS](MACOS.md),
* [Raspberry Pi 5, server](RPI5-server.md),
* [Raspberry Pi 5, desktop](RPI5-desktop.md),
* [Keychron keyboards](KEYCHRON.md).

## TODO

* Fix install of Terminator on Kali
* Move documentation to cs-notes
* Complete and link RPI5.md
* KEYCHRON.md

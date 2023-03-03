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

./configure/zsh.sh
./install/zsh-p10k.sh
./install/zsh-defer.sh

apt-update.sh

./configure/git.sh

./install/debian-misc.sh
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

### macOS

See [macOS](MACOS.md).

## TODO

### Misc

* Move documentation to cs-notes

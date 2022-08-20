#!/usr/bin/env sh

set -exu

bck_dir=backup-$(date "+%Y%m%d-%H%M%S")
mkdir $bck_dir

#
# /Applications
#

# List of all apps
ls -1 /Applications > $bck_dir/application-list.txt

# App Store
mas list | sed -E 's/[ ]{2,}/;;;/g' | awk -F";;;" '{print "mas install " $2 }' > $bck_dir/mas-install.sh
chmod u+x $bck_dir/mas-install.sh

# Brave Browser
mkdir $bck_dir/brave
cp -R ~/Library/Application\ Support/BraveSoftware/Brave-Browser/{Default,Profile*} $bck_dir/brave

# Divvy
cp ~/Library/Preferences/com.mizage.Divvy.plist $bck_dir

# Firefox
mkdir $bck_dir/firefox
cp -R ~/Library/Application\ Support/Firefox/Profiles $bck_dir/firefox

# Karabiner Elements
cp ~/.config/karabiner/karabiner.json $bck_dir

# Safari Bookmarks
cp ~/Library/Safari/Bookmarks.plist $bck_dir

# Typora
cp ~/Library/Preferences/abnerworks.Typora.plist $bck_dir

# VSCode
mkdir $bck_dir/vscode
cp -R ~/.vscode $bck_dir/vscode/dotfolder
cp -R ~/Library/Application\ Support/Code/User/snippets $bck_dir/vscode
cp ~/Library/Application\ Support/Code/User/{settings,keybindings}.json $bck_dir/vscode

# VLC
cp ~/Library/Preferences/org.videolan.vlc.plist $bck_dir

# iTerm
echo Manually backup iTerm preferences: https://nyg.gitbook.io/cs-notes/softwares/ctrl-key-shortcuts-iterm#preferences-backup-and-restore


#
# Homebrew
#

brew leaves --installed-on-request | xargs -n1 echo brew install > $bck_dir/brew-install.sh
chmod u+x $bck_dir/brew-install.sh

brew list --cask | xargs -n1 echo brew install --cask > $bck_dir/brew-cask-install.sh
chmod u+x $bck_dir/brew-cask-install.sh


#
# Misc
#

# SSH keys
mkdir $bck_dir/ssh-keys
cp ~/.ssh/*@* $bck_dir/ssh-keys

# Custom hosts
cat /etc/hosts | grep '# back-up' > $bck_dir/etc-hosts

# ZSH
cp ~/.zsh_history $bck_dir/zsh_history


#
# Create archive
#

tar -cf $bck_dir.tar $bck_dir

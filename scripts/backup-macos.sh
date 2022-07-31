#!/usr/bin/env sh

bck_dir=backup-$(date "+%Y%m%d-%H%M%S")
mkdir $bck_dir

#
# /Applications
#

# application list
ls -1 /Applications > application-list.txt

# App Store
mas list | sed -E 's/[ ]{2,}/;;;/g' | awk -F";;;" '{print "mas install " $2 }' > mas-install.sh
chmod u+x mas-install.sh

# Brave Browser
# TODO backup profiles and settings

# CotEditor
# TODO pref

# Cryptowatch Desktop
# TODO settings

# Divvy
# TODO settings

# Docker
# TODO settings ?

# Electrum
# TODO keys ?

# copy Firefox profiles
cp -R ~/Library/Application\ Support/Firefox/Profiles $bck_dir/profiles

# iTerm
# Then restore from the iTerm Preferences panel
cp ~/Library/Preferences/com.googlecode.iterm2.plist $bck_dir
cp ~/Library/autojump/autojump.txt $bck_dir

# Karabiner Elements
cp ~/.config/karabiner/karabiner.json $bck_dir

# Logi Options
# TODO

# Safari
cp ~/Library/Safari/Bookmarks.plist $bck_dir
# TODO preferences

# Telegram
# TODO preferences

# Transmission
# TODO preferences

# Typora
# TODO preferences

# VSCode
mkdir $bck_dir/vscode
cp -R ~/.vscode $bck_dir/vscode/dotfolder
cp -R ~/Library/Application\ Support/Code/User/snippets $bck_dir/vscode
cp ~/Library/Application\ Support/Code/User/settings.json $bck_dir/vscode
# TODO

# VLC
# TODO preferences

# copy SSH keys
cp -R ~/.ssh/*@* $bck_dir/ssh

#
# Homebrew
#

brew leaves --installed-on-request | xargs -n1 echo brew install > brew-install.sh
chmod u+x brew-install.sh

brew list --cask | xargs -n1 echo brew install --cask > brew-cask-install.sh
chmod u+x brew-cask-install.sh

#
# zsh & oh-my-zsh
#



# cron ? zsh history, npmrc savexact, sandisk key

cat /etc/hosts | grep '# back-up' > hosts.txt
# check which config can be added to git and symlinked



# create archive
tar -cf $bck_dir.tar $bck_dir

#!/usr/bin/env sh

bck_dir=backup-$(date "+%Y%m%d-%H%M%S")
mkdir $bck_dir

# copy SSH keys
cp -R ~/.ssh $bck_dir/ssh

# copy Safari Bookmarks
cp ~/Library/Safari/Bookmarks.plist $bck_dir

# copy Firefox profiles
cp -R ~/Library/Application\ Support/Firefox/Profiles $bck_dir/profiles

# iTerm
# Then restore from the iTerm Preferences panel
cp ~/Library/Preferences/com.googlecode.iterm2.plist $bck_dir

# VSCode
mkdir $bck_dir/vscode
cp -R ~/.vscode $bck_dir/vscode/dotfolder
cp -R ~/Library/Application\ Support/Code/User/snippets $bck_dir/vscode
cp ~/Library/Application\ Support/Code/User/settings.json $bck_dir/vscode

# Homebrew
brew leaves --installed-on-request > brew-installed.txt
brew list --cask > brew-installed-cask.txt

# create archive
tar -cf $bck_dir.tar $bck_dir

# ln -s $HOME/.$USER-sh/config/ssh $HOME/.ssh/config

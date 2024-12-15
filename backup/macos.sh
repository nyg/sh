#!/usr/bin/env sh

set -exu

bck_dir=backup-$(date "+%Y%m%d-%H%M%S")
mkdir $bck_dir

#
# List of installed applications
#

# /Applications folder
ls -1 /Applications > $bck_dir/application-list.txt

# App Store
mas list | sed -E 's/[ ]{2,}/;;;/g' | awk -F";;;" '{print "mas install " $1 " # " $2 }' > $bck_dir/mas-install.sh
chmod u+x $bck_dir/mas-install.sh

# Homebrew
brew leaves --installed-on-request | xargs -n1 echo brew install > $bck_dir/brew-install.sh
chmod u+x $bck_dir/brew-install.sh

# Homebrew casks
brew list --cask | xargs -n1 echo brew install --cask > $bck_dir/brew-cask-install.sh
chmod u+x $bck_dir/brew-cask-install.sh


#
# Backup preferences and data
#

# AltTab
cp ~/Library/Preferences/com.lwouis.alt-tab-macos.plist $bck_dir

# Brave Browser profiles
mkdir $bck_dir/brave
cp -R ~/Library/Application\ Support/BraveSoftware/Brave-Browser/{Default,Profile*} $bck_dir/brave

# Divvy
cp ~/Library/Preferences/com.mizage.Divvy.plist $bck_dir

# Firefox profiles
mkdir $bck_dir/firefox
cp -R ~/Library/Application\ Support/Firefox/Profiles $bck_dir/firefox

# IINA
cp ~/Library/Preferences/com.colliderli.iina.plist $bck_dir
# on new host: copy preferences, delete ~/Library/Caches/com.colliderli.iina/, start app

# iTerm
echo Manually backup iTerm preferences: https://notes.andstuff.dev/softwares/iterm2/#preferences-backup-restore

# Karabiner Elements
mkdir $bck_dir/karabiner
cp -R ~/.config/karabiner $bck_dir/karabiner

# Safari Bookmarks
cp ~/Library/Safari/Bookmarks.plist $bck_dir

# Transmission
cp ~/Library/Preferences/org.m0k.transmission.plist $bck_dir

# Typora
cp ~/Library/Preferences/abnerworks.Typora.plist $bck_dir
# on new host: rm -rf ~/Library/Caches/abnerworks.Typora/
# https://github.com/typora/typora-issues/issues/2353

# VSCode
mkdir $bck_dir/vscode
cp -R ~/.vscode-oss $bck_dir/vscode/dotfolder
cp -R ~/Library/Application\ Support/VSCodium/User/snippets $bck_dir/vscode
cp ~/Library/Application\ Support/VSCodium/User/{settings,keybindings}.json $bck_dir/vscode
# on new host:
# rm -rf ~/.vscode-oss
# cp -R dotfolder ~/.vscode-oss
# cp snippets/* ~/Library/Application\ Support/VSCodium/User/snippets/
# cp keybindings.json settings.json ~/Library/Application\ Support/VSCodium/User/

# VLC
mkdir $bck_dir/vlc
cp ~/Library/Preferences/org.videolan.vlc.plist $bck_dir/vlc
cp ~/Library/Preferences/org.videolan.vlc/vlcrc $bck_dir/vlc
# on new host: delete ~/Library/Caches/org.videolan.vlc/

# Zed
mkdir $bck_dir/zed
cp ~/.config/zed/{keymap,settings}.json $bck_dir/zed

#
# Misc
#

# SSH keys
mkdir $bck_dir/ssh-keys
cp ~/.ssh/*@* $bck_dir/ssh-keys

# Custom hosts
cat /etc/hosts | grep '# back-up' > $bck_dir/etc-hosts

# ZSH
cp "$HISTFILE" $bck_dir/shell_history

# Maven
mkdir $bck_dir/maven
cp ~/.m2/{settings.xml,mvnd.properties} $bck_dir/maven

#
# Create archive
#

tar -cf $bck_dir.tar $bck_dir

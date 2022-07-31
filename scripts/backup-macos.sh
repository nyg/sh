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
cp -R ~/Library/Application\ Support/BraveSoftware/Brave-Browser/{Default,Profile*} $bck_dir

# Divvy
cp ~/Library/Preferences/com.mizage.Divvy.plist $bck_dir

# Firefox
cp -R ~/Library/Application\ Support/Firefox/Profiles $bck_dir/profiles

# iTerm
# To restore: General > Preferences > Load preferences from a custom folder or URL
mkdir $bck_dir/iterm
cp ~/Library/Preferences/com.googlecode.iterm2.plist $bck_dir/iterm
cp ~/Library/autojump/autojump.txt $bck_dir/iterm
cp ~/.zsh_history $bck_dir/iterm

# Karabiner Elements
cp ~/.config/karabiner/karabiner.json $bck_dir

# Safari
cp ~/Library/Safari/Bookmarks.plist $bck_dir

# Transmission
cp ~/Library/Preferences/org.m0k.transmission.plist $bck_dir

# Typora
cp ~/Library/Preferences/abnerworks.Typora.plist $bck_dir

# VSCode
mkdir $bck_dir/vscode
cp -R ~/.vscode $bck_dir/vscode/dotfolder
cp -R ~/Library/Application\ Support/Code/User/snippets $bck_dir/vscode
cp ~/Library/Application\ Support/Code/User/{settings,keybindings}.json $bck_dir/vscode

# VLC
cp ~/Library/Preferences/org.videolan.vlc.plist $bck_dir


#
# Homebrew
#

brew leaves --installed-on-request | xargs -n1 echo brew install > brew-install.sh
chmod u+x brew-install.sh

brew list --cask | xargs -n1 echo brew install --cask > brew-cask-install.sh
chmod u+x brew-cask-install.sh


#
# Misc
#

# SSH keys
cp -R ~/.ssh/*@* $bck_dir/ssh

# Custom hosts
cat /etc/hosts | grep '# back-up' > hosts.txt

# cron


# create archive
tar -cf $bck_dir.tar $bck_dir

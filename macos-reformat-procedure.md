## Before

1. Create Time Machine backups on two differents disks.
2. Create a bootable USB key for the future OS:
   1. Click on App Store download link in https://support.apple.com/en-us/HT201372.
   3. Execute command `sudo /Applications/Install\ macOS\ Monterey.app/Contents/Resources/createinstallmedia --volume /Volumes/<MyVolume>`
3. Manually backup some files:
   1. `cd .user-sh; ./backup/macos.sh`
   2. backup resulting file
   3. backup Movies/Pictures/Music
   4. backup iTerm2 configuration

## During

1. Boot from the USB key using the Option key.
2. Reformat disk with Disk Utility (do not encrypt).
3. Start install.

## After

1. Update macOS and configure auto-update settings.

2. Configure iCloud settings.

3. Download and setup 1Password: https://1password.com/downloads/mac/.

5. Bootstap `sh` with `sh <(curl -s https://git.sr.ht/~nyg/sh/blob/master/bootstrap.sh)`.
   - SSH
     - Copy SSH keys from backup disk to ~/.ssh folder
     - `./configure/ssh-client.sh`
   - Git
     ```shell
     ./configure/git.sh
     git remote add upstream git@git.sr.ht:~nyg/sh
     git remote set-url origin git@git.sr.ht:~nyg/sh-<id>
     git push -u origin master
     ```
   
   - Vim
   
     - `./configure/vim.sh` (but needs to modify manually ~/.zshrc to add VIMINIT)
   
   - Install macOS softwares
   
     - Copy *.sh files from backup archive
     - Modify brew-install.sh, brew-cask-install.sh and ams-install.sh
     - Run files
     - Restore .plist files
     - Configure installed software
   
   - `./configure/zsh.sh` (can be run before ssh now)
   
   - TODO: mas install should use ids not app names
   
   - TODO: push install files to repo
   
   - TODO: update documentation on how to set upstream repo
   
   - TODO: backup CotEditor preferences
   
6. Configure System Preferences and Finder preferences.
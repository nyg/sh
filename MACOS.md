## Before

1. Create Time Machine backups on two differents disks.
2. Create a bootable USB key for the future OS:
   1. Click on App Store download link in https://support.apple.com/en-us/HT201372.
   3. Execute command `sudo /Applications/Install\ macOS\ Monterey.app/Contents/Resources/createinstallmedia --volume /Volumes/<MyVolume>`
3. Manually backup some files:
   1. `cd .user-sh; ./backup/macos.sh`
   2. Backup resulting file.
   3. Backup Movies/Pictures/Music.
   4. Backup iTerm2 configuration manually.

## During

1. Boot from the USB key using the Option key.
2. Reformat disk with Disk Utility (do not encrypt).
3. Start install.

## After

1. Update macOS and configure auto-update settings.
2. Configure iCloud settings.
3. Download and setup 1Password: https://1password.com/downloads/mac/.
4. Bootstrap `sh` with `sh <(curl -s https://git.sr.ht/~nyg/sh/blob/master/bootstrap.sh)`.
5. While bootstrap runs, configure System Preferences and macOS apps preferences.
6. Run bootstrap configuration and install scripts:
   1. Zsh
      ```shell
      ./configure/zsh.sh
      ./install/p10k.sh
      ```
   2. SSH
      ```shell
      cp /Volumes/<path-to-ssh-keys> ~/.ssh
      ./configure/ssh-client.sh
      ```
   3. Git
      ```shell
      ./configure/git.sh
      git remote add upstream git@git.sr.ht:~nyg/sh
      git remote set-url origin git@git.sr.ht:~nyg/sh-<id>
      git push -u origin master
      ```
   4. Vim
      ```shell
      ./configure/vim.sh
      ```
   5. Install macOS softwares
      ```shell
      ./install/misc-macos-brew.sh
      ./install/misc-macos-brew-cask.sh
      <TODO mac app store with mas>
      <TODO restore .plist files>
      <TODO manually configure installed software>
   6. TODO: update documentation on how to set upstream repo
   7. TODO: backup CotEditor preferences
   8. TODO: jenv, pyenv, volta

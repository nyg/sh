#!/usr/bin/env sh

set -exu

#
# General

defaults write -app Transmission AutoSize -bool true
defaults write -app Transmission CheckRemoveDownloading -bool true
defaults write -app Transmission CheckQuitDownloading -bool true
defaults write -app Transmission AutoUpdateBeta -bool true

#
# Transfers

# doesn't update the UI, works?
# defaults write -app Transmission DownloadLocationConstant -bool true
# defaults write -app Transmission DownloadFolder -string "$HOME/Movies"

# defaults write -app Transmission AutoStartDownload -bool true
defaults write -app Transmission DeleteOriginalTorrent -bool true

# doesn't work
# defaults write -app Transmission MagnetOpenAsk -bool true

defaults write -app Transmission RatioCheck -bool true

#
# Bandwidth

defaults write -app Transmission SpeedLimitDownloadLimit -int 200
defaults write -app Transmission SpeedLimitUploadLimit -int 50

#
# Peers

defaults write -app Transmission EncryptionRequire -bool true

defaults write -app Transmission BlocklistNew -bool true
defaults write -app Transmission BlocklistURL -string "https://github.com/Naunter/BT_BlockLists/raw/master/bt_blocklists.gz"
defaults write -app Transmission BlocklistAutoUpdate -bool true

#
# Network

defaults write -app Transmission RandomPort -bool true


#
# UI

defaults write -app Transmission WarningDonate -bool false
defaults write -app Transmission WarningLegal -bool false

defaults write -app Transmission "NSToolbar Configuration TRMainToolbar" -dict "TB Icon Size Mode" 1 "TB Is Shown" 0 "TB Display Mode" 2 "TB Size Mode" 1

defaults write -app Transmission Sort -string Progress
defaults write -app Transmission SortReverse -bool true

#!/usr/bin/env sh

set -exu

#
# Preferences

# General
defaults write com.apple.Safari OpenPrivateWindowWhenNotRestoringSessionAtLaunch -bool false
defaults write com.apple.Safari NewWindowBehavior -int 1
defaults write com.apple.Safari NewTabBehavior -int 1
defaults write com.apple.Safari HistoryAgeInDaysLimit -int 365000
defaults write com.apple.Safari.SandboxBroker AlwaysPromptForDownloadFolder -bool false
defaults write com.apple.Safari DownloadsClearingPolicy -int 2
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Tabs
defaults write com.apple.Safari EnableNarrowTabs -bool true
defaults write com.apple.Safari TabCreationPolicy -int 1
defaults write com.apple.Safari CommandClickMakesTabs -bool true
defaults write com.apple.Safari OpenNewTabsInFront -bool false
defaults write com.apple.Safari Command1Through9SwitchesTabs -bool false

# AutoFill
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# Search
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari WebsiteSpecificSearchEnabled -bool false
defaults write com.apple.Safari PreloadTopHit -bool false
defaults write com.apple.Safari ShowFavoritesUnderSmartSearchField -bool false

# Security
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true
defaults write com.apple.Safari.SafeBrowsing SafeBrowsingEnabled -bool true
defaults write com.apple.Safari WebKitJavaScriptEnabled -bool true
defaults write com.apple.Safari WebKitPreferences.javaScriptEnabled -bool true

# Privacy
defaults write com.apple.Safari WebKitStorageBlockingPolicy -int 1
defaults write com.apple.Safari WebKitPreferences.storageBlockingPolicy -int 1
defaults write com.apple.Safari BlockStoragePolicy -int 2
defaults write com.apple.Safari WebKitPreferences.applePayCapabilityDisclosureAllowed -bool true
defaults write com.apple.Safari WebKitPreferences.privateClickMeasurementEnabled -bool false

# Advanced
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
defaults write com.apple.Safari LastMinimumFontSize -int 9
defaults write com.apple.Safari WebKitPreferences.minimumFontSize -float 0
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool false
defaults write com.apple.Safari WebKitPreferences.tabFocusesLinks -bool false
defaults write com.apple.Safari ReadingListSaveArticlesOfflineAutomatically -bool false
defaults write com.apple.Safari.SandboxBroker ShowDevelopMenu -bool true
defaults write com.apple.Safari WebKitPreferences.developerExtrasEnabled -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true

#
# UI

defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false
defaults write com.apple.Safari ShowFavoritesBar-v2 -bool true
defaults write com.apple.Safari ShowOverlayStatusBar -bool true
defaults write com.apple.Safari AlwaysShowTabBar -bool false

defaults write com.apple.Safari "NSToolbar Configuration BrowserToolbarIdentifier-v4.6" -dict-add "TB Item Identifiers" '(BackForwardToolbarIdentifier,NSToolbarFlexibleSpaceItem,InputFieldsToolbarIdentifier,NSToolbarFlexibleSpaceItem)'
defaults write com.apple.Safari OrderedToolbarItemIdentifiers -array BackForwardToolbarIdentifier NSToolbarFlexibleSpaceItem InputFieldsToolbarIdentifier NSToolbarFlexibleSpaceItem

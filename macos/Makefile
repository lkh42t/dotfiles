TARGETS := \
	keyboard \
	mouse \
	dock \
	finder \
	menubar \
	screencapture

.PHONY: all $(TARGETS)

all: $(TARGETS)

keyboard:
	defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
	defaults write NSGlobalDomain InitialKeyRepeat -int 15
	defaults write NSGlobalDomain KeyRepeat -int 2
	defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
	defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true
	defaults write com.apple.inputmethod.Kotoeri JIMPrefCharacterForSlashKey -int 1
	defaults write com.apple.inputmethod.Kotoeri JIMPrefCharacterForYenKey -int 1
	defaults write com.apple.inputmethod.Kotoeri JIMPrefLiveConversionKey -bool 0
	defaults write com.apple.inputmethod.Kotoeri JIMPrefPunctuationTypeKey -int 0

mouse:
	defaults write NSGlobalDomain com.apple.mouse.scaling -float 3.0
	defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

dock:
	defaults write com.apple.dock autohide -bool true
	defaults write com.apple.dock mru-spaces -bool false
	defaults write com.apple.dock show-recents -bool false
	killall Dock

finder:
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true
	defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
	defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
	defaults write com.apple.finder ShowPathbar -bool true
	killall Finder

menubar:
	defaults write NSGlobalDomain AppleMenuBarVisibleInFullscreen -bool false
	defaults write NSGlobalDomain _HIHideMenuBar -bool true

screencapture:
	defaults write com.apple.screencapture disable-shadow -bool true
	defaults write com.apple.screencapture location -string '~/Pictures/Screenshots'

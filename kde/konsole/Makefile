include ../../config.mk

.PHONY: all
all:
	mkdir -p $(XDG_DATA_HOME)/konsole
	ln -sf $(abspath MyProfile.profile) $(XDG_DATA_HOME)/konsole
	$(KWRITECONFIG) --file konsolerc --group 'Desktop Entry' --key DefaultProfile MyProfile.profile
	$(KWRITECONFIG) --file konsolerc --group TabBar --key TabBarVisibility AlwaysShowTabBar
	$(KWRITECONFIG) --file konsolerc --group ThumbnailsSettings --key ThumbnailCtrl --type bool true

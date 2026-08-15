include ../config.mk

PLASMA_SETTINGS := \
	baloofilerc \
	kcminputrc \
	ksmserverrc \
	kwinrc \
	plasma-localerc
APPS := dolphin konsole

.PHONY: all plasma $(PLASMA_SETTINGS) $(APPS)

all: plasma $(APPS)

plasma: $(PLASMA_SETTINGS)
	$(QDBUS) org.kde.KWin /KWin reconfigure

baloofilerc:
	$(KWRITECONFIG) --file $@ --group General --key 'only basic indexing' --type bool true

kcminputrc:
	$(KWRITECONFIG) --file $@ --group Keyboard --key KeyRepeat repeat
	$(KWRITECONFIG) --file $@ --group Keyboard --key NumLock 2
	$(KWRITECONFIG) --file $@ --group Keyboard --key RepeatDelay 225
	$(KWRITECONFIG) --file $@ --group Keyboard --key RepeatRate 33.33
	for dev in $$($(QDBUS) org.kde.KWin /org/kde/KWin/InputDevice org.kde.KWin.InputDeviceManager.ListPointers); do \
		path="/org/kde/KWin/InputDevice/$$dev"; \
		vid=$$($(QDBUS) org.kde.KWin "$$path" org.freedesktop.DBus.Properties.Get org.kde.KWin.InputDevice vendor); \
		pid=$$($(QDBUS) org.kde.KWin "$$path" org.freedesktop.DBus.Properties.Get org.kde.KWin.InputDevice product); \
		name=$$($(QDBUS) org.kde.KWin "$$path" org.freedesktop.DBus.Properties.Get org.kde.KWin.InputDevice name); \
		$(KWRITECONFIG) --file $@ --group Libinput --group "$$vid" --group "$$pid" --group "$$name" --key NaturalScroll --type bool true; \
		$(KWRITECONFIG) --file $@ --group Libinput --group "$$vid" --group "$$pid" --group "$$name" --key PointerAcceleration 1.000; \
		$(KWRITECONFIG) --file $@ --group Libinput --group "$$vid" --group "$$pid" --group "$$name" --key ScrollFactor 1; \
	done

ksmserverrc:
	$(KWRITECONFIG) --file $@ --group General --key loginMode emptySession

kwinrc:
	$(KWRITECONFIG) --file $@ --group org.kde.kdecoration2 --key ButtonsOnLeft XIA
	$(KWRITECONFIG) --file $@ --group org.kde.kdecoration2 --key ButtonsOnRight ''

plasma-localerc:
	$(KWRITECONFIG) --file $@ --group Formats --key LANG C
	$(KWRITECONFIG) --file $@ --group Formats --key LC_MONETARY ja_JP.UTF-8

dolphin:
	$(KWRITECONFIG) --file dolphinrc --group DetailsMode --key PreviewSize 16
	$(KWRITECONFIG) --file dolphinrc --group General --key RememberOpenedTabs --type bool false

konsole:
	mkdir -p $(XDG_DATA_HOME)/konsole
	ln -sf $(abspath konsole/MyProfile.profile) $(XDG_DATA_HOME)/konsole
	$(KWRITECONFIG) --file konsolerc --group 'Desktop Entry' --key DefaultProfile MyProfile.profile
	$(KWRITECONFIG) --file konsolerc --group TabBar --key TabBarVisibility AlwaysShowTabBar
	$(KWRITECONFIG) --file konsolerc --group ThumbnailsSettings --key ThumbnailCtrl --type bool true

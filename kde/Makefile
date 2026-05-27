include ../config.mk

PLASMA_SETTINGS := \
	kcminputrc \
	kwinrc \
	plasma-localerc
APPS := dolphin konsole

.PHONY: all plasma $(PLASMA_SETTINGS) $(APPS)

all: plasma $(APPS)

$(APPS):
	$(MAKE) -C $@

plasma: $(PLASMA_SETTINGS)
	$(QDBUS) org.kde.KWin /KWin reconfigure

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

kwinrc:
	$(KWRITECONFIG) --file $@ --group org.kde.kdecoration2 --key ButtonsOnLeft XIA
	$(KWRITECONFIG) --file $@ --group org.kde.kdecoration2 --key ButtonsOnRight ''

plasma-localerc:
	$(KWRITECONFIG) --file $@ --group Formats --key LANG C
	$(KWRITECONFIG) --file $@ --group Formats --key LC_MONETARY ja_JP.UTF-8

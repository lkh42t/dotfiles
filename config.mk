XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_DATA_HOME ?= $(HOME)/.local/share

.PHONY: config-home
config-home:
	mkdir -p $(XDG_CONFIG_HOME)

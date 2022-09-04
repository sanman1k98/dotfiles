
XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_DATA_HOME ?= $(HOME)/.local/share

.PHONY : \
	clean.nvim \
	install.nvim

clean.nvim :
	rm -rf $(XDG_DATA_HOME)/nvim/site/pack/*
	rm $(XDG_CONFIG_HOME)/nvim/plugin/packer_compiled.lua

install.nvim :
	nvim --headless -u NONE -c "lua require('utils.bootstrap').install_plugins()"



#	Use this directory as config home
#
XDG_CONFIG_HOME = .

#	default locations
#
XDG_DATA_HOME ?= $(HOME)/.local/share
XDG_STATE_HOME ?= $(HOME)/.local/state
XDG_CACHE_HOME ?= $(HOME)/.cache
ZDOTDIR ?= $(HOME)

NVIM_LOG_FILE ?= $(XDG_STATE_HOME)/nvim/log

.PHONY : \
	nvim.test \
	nvim.clean.all \
	nvim.clean.plugins \
	nvim.clean.logs \
	zsh.symlinks


#
#
#		nvim
#
#

nvim.test :
	 nvim --headless \
		--noplugin \
		-u $(XDG_CONFIG_HOME)/nvim/tests/testing_init.lua \
		-c "PlenaryBustedDirectory $(XDG_CONFIG_HOME)/nvim/tests/ { minimal_init = '$(XDG_CONFIG_HOME)/nvim/tests/testing_init.lua'}"

nvim.clean.all : | nvim.clean.logs nvim.clean.plugins

nvim.clean.plugins :
	rm -rf $(XDG_DATA_HOME)/nvim/site/lazy/*
	rm -rf $(XDG_DATA_HOME)/nvim/site/pack/*
	rm $(XDG_CONFIG_HOME)/nvim/plugin/packer_compiled.lua

nvim.clean.logs :
	rm $(NVIM_LOG_FILE)
	rm -rf $(XDG_STATE_HOME)/nvim/*.log


#
#
#		zsh
#
#

zsh.symlinks :
	ln -s $(ZDOTDIR)/.zshenv $(XDG_CONFIG_HOME)/zsh/zshenv
	ln -s $(ZDOTDIR)/.zshrc $(XDG_CONFIG_HOME)/zsh/zshrc


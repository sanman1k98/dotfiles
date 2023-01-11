
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
	nvim.profile \
	nvim.bootstrap \
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

nvim.bootstrap :
	nvim --headless -u NONE -c "lua require('utils.bootstrap').install_plugins()"

nvim.profile :
	@nvim --startuptime $(NVIM_LOG_FILE) "+qa!"
	@bat $(NVIM_LOG_FILE)

nvim.test :
	XDG_CONFIG_HOME="./" nvim --headless \
		--noplugin \
		-u ./nvim/tests/testing_init.lua \
		-c "PlenaryBustedDirectory ./nvim/tests/ { minimal_init = './nvim/tests/testing_init.lua'}"

nvim.clean.all : | nvim.clean.logs nvim.clean.plugins

nvim.clean.plugins :
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


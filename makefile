
XDG_CONFIG_HOME ?= $(HOME)/.config

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
	 cd nvim && nvim --headless \
		--noplugin \
		-u ./tests/testing_init.lua \
		-c "PlenaryBustedDirectory ./tests/ { minimal_init = './tests/testing_init.lua' }"

nvim.clean.all : | nvim.clean.logs nvim.clean.plugins

nvim.clean.plugins :
	rm -rf $(XDG_DATA_HOME)/nvim/site/lazy/*

nvim.clean.logs :
	rm $(NVIM_LOG_FILE)
	rm -rf $(XDG_STATE_HOME)/nvim/*.log


#
#
#		zsh
#
#

zsh.symlinks :
	ln -s $(XDG_CONFIG_HOME)/zsh/zshenv $(ZDOTDIR)/.zshenv
	ln -s $(XDG_CONFIG_HOME)/zsh/zshrc $(ZDOTDIR)/.zshrc


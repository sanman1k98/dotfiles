
XDG_CONFIG_HOME ?= $(HOME)/.config

#	default locations
#
XDG_DATA_HOME ?= $(HOME)/.local/share
XDG_STATE_HOME ?= $(HOME)/.local/state
XDG_CACHE_HOME ?= $(HOME)/.cache
TMP ?= $(TMPDIR)
ZDOTDIR ?= $(HOME)

TERMINFO_DIRS ?= $(XDG_DATA_HOME)/terminfo

install : \
	brew \
	zsh \
	wezterm

#
#
#		brew
#
#

HOMEBREW_INSTALL = $(TMP)/homebrew-install.sh
HOMEBREW_BUNDLE_FILE ?= $(XDG_CONFIG_HOME)/brew/Brewfile
HOMEBREW_BUNDLE_LOCK = $(HOMEBREW_BUNDLE_FILE).lock.json

$(HOMEBREW_INSTALL) :
	curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh' > $@

$(HOMEBREW_BUNDLE_LOCK) : $(HOMEBREW_INSTALL)
	type brew || /bin/sh $(HOMEBREW_INSTALL)
	brew bundle install --file $(HOMEBREW_BUNDLE_FILE)

brew : $(HOMEBREW_BUNDLE_LOCK)

#
#
#		wezterm
#
#

WEZTERM_TERMINFO = $(XDG_DATA_HOME)/wezterm/wezterm.terminfo

$(WEZTERM_TERMINFO) :
	curl -fsSL 'https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo' --output $@

wezterm : $(WEZTERM_TERMINFO)
	tic -x -o $(TERMINFO_DIRS) $(WEZTERM_TERMINFO)

.PHONY : \
	nvim.test \
	nvim.clean.all \
	nvim.clean.plugins \
	nvim.clean.logs


#
#
#		nvim
#
#

NVIM_LOG_FILE ?= $(XDG_STATE_HOME)/nvim/log

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

ZSHENV = $(HOME)/.zshenv
ZSHRC = $(HOME)/.zshrc

$(ZSHENV) :
	ln -fhs $(XDG_CONFIG_HOME)/zsh/zshenv $@

$(ZSHRC) :
	ln -fhs $(XDG_CONFIG_HOME)/zsh/zshrc $@

zsh : $(ZSHENV) $(ZSHRC)

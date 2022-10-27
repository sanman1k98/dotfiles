export MANPAGER='nvim +Man!'
export EDITOR='nvim'

export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"

#
#		Aliases
#

# for navigating around
alias -g la='ls -lAG --color=always'

# editor
alias -g nv="nvim"
alias -g vi="nvim --noplugin"

# CLI tools
alias -g lg='lazygit'
alias -g g="git"



#
#		case insensitive completions
#
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

setopt nobeep
setopt interactivecomments
setopt nocaseglob
setopt menucomplete

#
#		history options
#
setopt histreduceblanks
setopt extendedhistory
setopt sharehistory
setopt appendhistory
setopt histverify


if [[ $(where brew) ]]; then
	brew_completions="$(brew --prefix)/share/zsh/site-functions"
	fpath+=brew_completions
fi

# initialize completion and prompt engine

#	load Node version manager
#
test -e "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh" && source $_

autoload -Uz compinit promptinit
compinit -u
promptinit

# TODO: use XDG_CONFIG_DIRS
#
# aliases for work
work_aliases="$HOME/.work_config/zsh/alises.zsh"
if [[ -e work_aliases ]]; then
	source work_aliases
fi

# TODO: see if there is a better way to do this... the square brackets are
# probably redundant.
#
# Source starship prompt very last
if [[ $(where starship) ]]; then
	source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
	source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	eval $(starship init zsh)
else
	echo "starship prompt not installed."
	prompt off
fi

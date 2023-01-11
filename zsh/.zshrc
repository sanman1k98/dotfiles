
#
#		environment variables for CLI tools
#

export MANPAGER='nvim +Man!'
export EDITOR='nvim'
export VISUAL='nvim'

# TODO: export XDG_DATA_DIRS

# Homebrew prefix
export HOMEBREW_PREFIX="$(brew --prefix)"

# prompt configuration
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"

# lazygit configuration
export LG_CONFIG_FILE="${XDG_CONFIG_HOME}/lazygit/config.yml"


#
#		Aliases
#

# navigation
alias -g la='ls -lAG --color=always'

# editor
alias -g nv="nvim"
alias -g vi="nvim --noplugin"

# other
alias -g lg='lazygit'
alias -g g="git"

# TODO: use XDG_CONFIG_DIRS
# work
work_aliases="$HOME/.work_config/zsh/aliases.zsh"
if [[ -e work_aliases ]]; then
	source work_aliases
fi



#
#		interactive shell options
#

setopt nobeep
setopt interactivecomments
setopt nocaseglob
setopt menucomplete

#	history options
#
setopt histreduceblanks
setopt extendedhistory
setopt sharehistory
setopt appendhistory
setopt histverify

#	case insensitive completion
#
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'



#	zsh completions for Homebrew itself
#
test -d "${HOMEBREW_PREFIX}/share/zsh/site-functions" && fpath+="$_"

#	load Node version manager
#
test -e "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh" && source $_

#	initialize completion and prompt engines
#
autoload -Uz compinit promptinit
compinit -u
promptinit

#	load autosuggestions and syntax highlighting
#
test -e "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" && source $_
test -e "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" && source $_

#	initialize prompt
#
if command -v "starship" &>/dev/null; then
	eval $(starship init zsh)
else
	echo "starship prompt not installed." && prompt off
fi

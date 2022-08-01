export MANPAGER='nvim --clean +Man!'
export EDITOR='nvim'

export STARSHIP_CONFIG=~/.config/starship/starship.toml

alias -g la='ls -lAG --color=always'
alias -g lg='lazygit'

setopt nobeep
setopt interactivecomments
setopt autocd
setopt nocaseglob
setopt autolist
setopt menucomplete

# history options
setopt extendedhistory
setopt sharehistory
setopt appendhistory
setopt histverify

if [[ $(where brew) ]]; then
	brew_completions="$(brew --prefix)/share/zsh/site-functions"
	fpath+=brew_completions
fi

autoload -Uz compinit promptinit
compinit -u
promptinit

# aliases for work
if [[ -e $HOME/.work_config/zsh/aliases.zsh ]]; then
	source $HOME/.work_config/zsh/aliases.zsh
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

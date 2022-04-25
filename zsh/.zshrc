export MANPAGER='nvim +Man!'
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

autoload -Uz compinit promptinit
compinit -u
promptinit

# TODO: wrap in if statement
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval $(starship init zsh)

export MANPAGER='nvim +Man!'
export EDITOR='nvim'

alias -g la='ls -lAG'

setopt nobeep
setopt autocd
setopt nocaseglob
setopt extendedhistory
setopt sharehistory
setopt appendhistory
setopt histverify

autoload -Uz compinit promptinit
compinit -u
promptinit

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval $(starship init zsh)

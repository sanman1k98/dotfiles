alias la="ls -lAG --color=always"
alias nv="nvim"
alias vi="nvim --noplugin"
alias lg="lazygit"

if [[ "${TERM}" == "xterm-kitty" ]]; then
	alias theme="kitty +kitten themes --reload-in=all $*"
fi

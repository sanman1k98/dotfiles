statedir="${XDG_STATE_HOME}/zsh"
mkdir -p "${statedir}"
export HISTFILE="${statedir}/zhistory"

setopt nobeep
setopt interactivecomments
setopt nocaseglob
setopt menucomplete

setopt histreduceblanks
setopt extendedhistory
setopt sharehistory
setopt appendhistory
setopt histverify

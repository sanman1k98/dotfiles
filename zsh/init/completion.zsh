# add brew completions to fpath before compinit is called
fpath+="${HOMEBREW_PREFIX}/share/zsh/site-functions"

autoload -Uz compinit
cachedir="${XDG_CACHE_HOME}/zsh"
mkdir -p "${cachedir}"
compinit -d "${cachedir}/zcompdump"

zstyle ":completion:*" completer _extensions _complete _approximate

# case insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

source "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

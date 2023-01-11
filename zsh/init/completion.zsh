autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump"

zstyle ":completion:*" completer _extensions _complete _approximate

zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

source "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

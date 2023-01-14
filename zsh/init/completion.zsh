# add brew completions to fpath before compinit is called
fpath+="${HOMEBREW_PREFIX}/share/zsh/site-functions"

autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump"

zstyle ":completion:*" completer _extensions _complete _approximate

# case insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

test -d "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" && source "$_"

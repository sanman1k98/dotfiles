
export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'

export HISTFILE="${XDG_STATE_HOME}/zsh/zhistory"

# TODO: check if Homebrew is installed before exporting
export HOMEBREW_PREFIX="$(brew --prefix)"

# prompt config
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"

# lazygit config
export LG_CONFIG_FILE="${XDG_CONFIG_HOME}/lazygit/config.yml"

# node versino manager
export NVM_DIR="${XDG_DATA_HOME}/nvm"
test -e "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh --no-use" && source $_	# TODO: move this somewhere else

# store the branch name of the current config
export CONFIG_BRANCH="$(git -C ${XDG_CONFIG_HOME} branch --show-current)"

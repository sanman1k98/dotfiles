
export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'

# TODO: check if Homebrew is installed before exporting
export HOMEBREW_PREFIX="$(brew --prefix)"

# lazygit config
export LG_CONFIG_FILE="${XDG_CONFIG_HOME}/lazygit/config.yml"

# node versino manager
export NVM_DIR="${XDG_DATA_HOME}/nvm"
test -e "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh --no-use" && source $_	# TODO: move this somewhere else

# store the branch name of the current config
export CONFIG_BRANCH="$(git -C ${XDG_CONFIG_HOME} branch --show-current)"

# pfetch: a pretty system information tool
#
# Which information to display.
# Note: If 'ascii' will be used, it must come first.
# Valid: space separated string
#
# DEFAULT: ascii title os host kernel uptime pkgs memory
# OFF by default: shell editor wm de palette
export PF_INFO="ascii title os host kernel uptime pkgs memory palette"

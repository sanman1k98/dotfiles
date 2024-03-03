export NVIM_APPNAME='lazyvim'
export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'

export HOMEBREW_PREFIX="$(brew --prefix)"

# lazygit config
export LG_CONFIG_FILE="${XDG_CONFIG_HOME}/lazygit/config.yml"

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

# pnpm home directory
export PNPM_HOME="${XDG_DATA_HOME}/pnpm"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"

export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export LG_CONFIG_FILE="${XDG_CONFIG_HOME}/lazygit/config.yml"

typeset -U path 

# global PHP composer binaries
path+=$HOME/.composer/vendor/bin

# unversioned symlinks pointing to `python3` binaries
path+=/usr/local/opt/python@3.10/libexec/bin

#	Node version manager working directory
#
export NVM_DIR="${XDG_DATA_HOME}/nvm"


# TODO: use XDG_CONFIG_DIRS
#
#		work environment
#
work_env="${HOME}/.work_config/zsh/env.zsh"
if [[ -e work_env ]]; then
	source work_end
fi

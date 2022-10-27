export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"


#	Node version manager working directory
#
export NVM_DIR="${XDG_DATA_HOME}/nvm"


# TODO: use XDG_CONFIG_DIRS
#
#		work environment
#
work_env="${HOME}/.work_config/zsh/env.zsh"
if [[ -e work_env ]]; then
	source work_env
fi

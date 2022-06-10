export ZDOTDIR=$HOME/.config/zsh
export HOMEBREW_BUNDLE_FILE=$HOME/.config/brew/Brewfile
export LG_CONFIG_FILE=$HOME/.config/lazygit/config.yml

typeset -U fpath
fpath+=/usr/local/share/zsh-completions

typeset -U path 
# openresty's version of LuaJIT
path+=/usr/local/opt/luajit-openresty/bin

# global PHP composer binaries
path+=$HOME/.composer/vendor/bin

# unversioned symlinks pointing to `python3` binaries
path+=/usr/local/opt/python@3.10/libexec/bin



# work environment
if [[ -e $HOME/.work_config/zsh/env_vars.zsh ]]; then
	source $HOME/.work_config/zsh/env_vars.zsh
fi

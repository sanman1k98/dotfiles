# user-specific executable files according to the XDG Base Directories specification
path+="${HOME}/.local/bin"

# add cargo installed binaries to $PATH
path+="${HOME}/.cargo/bin"

# PHP composer global binaries
path+="${XDG_CONFIG_HOME}/composer/vendor/bin"

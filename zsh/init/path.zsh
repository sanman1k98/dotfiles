# user-specific executable files according to the XDG Base Directories specification
path+="${HOME}/.local/bin"

# add cargo installed binaries to $PATH
path+="${HOME}/.cargo/bin"

# nvim binaries managed with bob-nvim
path+="${XDG_DATA_HOME}/bob/nvim-bin"

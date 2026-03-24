#!/bin/bash

set -euo pipefail
shopt -s inherit_errexit

# Install Homebrew.
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Clone dotfiles.
git clone https://github.com/sanman1k98/dotfiles.git ~/.config

cd ~/.config

# Set up zsh.
make zsh

# Install programs and applications with Homebrew.
make brew

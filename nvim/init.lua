-- Load some basic nvim options
require('conf.sets')

-- Load my keymappings
require('conf.maps')

-- Load packer.nvim plugins
require('conf.packer')

-- Setup the lang servers
require 'plugins.lsp'

-- Set the colorscheme
require('conf.colors')


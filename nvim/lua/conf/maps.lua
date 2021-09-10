local map = require'conf.utils'.map
vim.g.mapleader = [[ ]]

map('i', 'kj', '<esc>')
map('n', '<leader>;', ':')
map('n', '<leader>e', '<cmd>Telescope fd<cr>')

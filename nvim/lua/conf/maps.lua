local map = require'conf.utils'.map
vim.g.mapleader = [[ ]]

map('i', 'kj', '<esc>')
map('n', '<leader>;', ':')
map('n', '<leader>e', '<cmd>Telescope fd<cr>')
map('n', '<leader>b', '<cmd>Telescope buffers<cr>')
map('n', '<leader>c', '<cmd>Telescope commands<cr>')
map('n', '<leader>t', '<cmd>NvimTreeToggle<cr>')

-- coq recommended mappings
vim.g.coq_settings = { keymap = { recommended = false } }
map('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true })
map('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true })
map('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true })
map('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true })

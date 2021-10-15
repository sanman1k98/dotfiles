local map = require'conf.utils'.map
vim.g.mapleader = [[ ]]

map('i', 'kj', '<esc>')
map('n', '<leader>;', ':')
map('n', '<leader>w', '<cmd>w<cr>')
map('v', '<leader>f', '<esc><cmd>lua vim.lsp.buf.range_formatting()<cr>')
map('n', '<leader>e', '<cmd>Telescope fd<cr>')
map('n', '<leader>b', '<cmd>Telescope buffers<cr>')
map('n', '<leader>c', '<cmd>Telescope commands<cr>')
map('n', '<leader>t', '<cmd>NvimTreeToggle<cr>')
map('n', '<leader>d', '<cmd>TroubleToggle lsp_workspace_diagnostics<cr>', { silent = true })
map('n', '<leader>z', '<cmd>ZenMode<cr>')

-- coq recommended mappings
vim.g.coq_settings = { keymap = { recommended = false } }
map('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true })
map('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true })
map('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true })
map('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true })

vim.g.mapleader = [[ ]]
local set_keymap = vim.api.nvim_set_keymap
local function map(modes, lhs, rhs, args)
  args = args or {}
	-- assign args.noremap to 'true' if it is not already defined
  args.noremap = (args.noremap == nil and true) or args.noremap
  if type(modes) == 'string' then modes = {modes} end
  for _, mode in ipairs(modes) do set_keymap(mode, lhs, rhs, args) end
end

-- better escape
map('i', 'kj', '<esc>')

-- I don't like pressing shift with my weak left pinky:(
map('n', '<leader>;', ':')

-- shortcut to get help in an new tab
map('n', '<leader>h', ':tab h ')

-- 
map('n', '<leader>w', '<cmd>w<cr>')

-- 
map('v', '<leader>f', '<esc><cmd>lua vim.lsp.buf.range_formatting()<cr>')

-- 
map('n', '<leader>e', '<cmd>Telescope fd<cr>')

-- 
map('n', '<leader>b', '<cmd>Telescope buffers<cr>')

-- 
map('n', '<leader>c', '<cmd>Telescope commands<cr>')

-- 
map('n', '<leader>t', '<cmd>NvimTreeToggle<cr>')

-- 
map('n', '<leader>d', '<cmd>TroubleToggle lsp_workspace_diagnostics<cr>', { silent = true })

-- 
map('n', '<leader>z', '<cmd>ZenMode<cr>')

-- coq recommended mappings
vim.g.coq_settings = { keymap = { recommended = false } }
map('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true })
map('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true })
map('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true })
map('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true })

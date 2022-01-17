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

-- search through help tags and open in a new window
map('n', '<leader>h', '<cmd>lua require"telescope.builtin".help_tags()<cr>')

-- write file
map('n', '<leader>w', '<cmd>w<cr>')

-- format selected
map('v', 'gw', '<esc><cmd>lua vim.lsp.buf.range_formatting()<cr>')

-- vim lsp code actions
map('n', '<leader>va', '<cmd>lua require"telescope.builtin".lsp_code_actions()<cr>')
map('n', '<leader>vr', '<cmd>lua vim.lsp.buf.rename()<cr>')

-- fuzzy find files
map("n", "<leader>ff", '<cmd>lua require"telescope.builtin".fd()<cr>')

-- buffers
map('n', '<leader>fb', '<cmd>lua require"telescope.builtin".buffers()<cr>')

-- search through commands
map('n', '<leader>c', '<cmd>lua require"telescope.builtin".commands()<cr>')

-- file tree
map('n', '<leader>ft', '<cmd>NvimTreeFocus<cr>')

-- toggle diagnostics window
map('n', '<leader>vd', '<cmd>TroubleToggle lsp_workspace_diagnostics<cr>', { silent = true })

--
map('n', '<leader>z', '<cmd>ZenMode<cr>')

-- coq recommended mappings
vim.g.coq_settings = { keymap = { recommended = false } }
map('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true })
map('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true })
map('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true })
map('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true })

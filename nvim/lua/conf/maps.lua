-- use WhichKey to seup and document mappings
local wk = require'which-key'

vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[,]]

wk.register {
	['kj'] = {'<esc>', 'Exit insert mode', mode = 'i'},
	['<c-space>'] = {'compe#complete()', 'Invoke compe', mode = 'i', expr = true }
}

wk.register {
	['<leader>'] = {
		[';'] = {':', 'Enter command mode', silent = false},
		e = {'<cmd>Telescope fd<cr>', 'Fuzzy find file to edit', silent = false},
		b = {'<cmd>Telescope buffers<cr>', 'Fuzzy switch to open buffer', silent = false},
		['?'] = {'<cmd>Cheatsheet<cr>', 'Open up cheatsheet'}
	}
}

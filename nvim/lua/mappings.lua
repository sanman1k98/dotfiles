vim.g.mapleader = [[ ]]
local map = require'utils.map'	-- custom map function

map {
	i = {
		['kj'] = {
			'<esc>',
			'quickly leave insert mode'
		}
	},

	n = {
		['<leader>;'] = {
			':',
			'easily enter a command'
		},

		['<leader>h'] = {
			function() require'telescope.builtin'.help_tags() end,
			'search help docs'
		},

		['<leader>w'] = {
			'<cmd> w <cr>',
			'write file'
		},

		['<leader>vr'] = {
			function() vim.lsp.rename() end,
			'rename a symbol'
		},

		['<leader>ff'] = {
			function() require'telescope.builtin'.find_files() end,
			'fuzzy find files'
		},

		['<leader>ft'] = {
			function()
				require'nvim-tree.api'.tree.focus()
			end,
			'focus file tree'
		},
	}
}

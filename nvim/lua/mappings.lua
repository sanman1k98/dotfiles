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

		['<leader>ff'] = {
			function() require'telescope.builtin'.find_files() end,
			'fuzzy find files'
		},

		['<leader>c'] = {
			function() require'telescope.builtin'.commands() end,
			'search for a command'
		},

		['<leader>ft'] = {
			function()
				require'nvim-tree.api'.tree.focus()
			end,
			'focus file tree'
		},

		['<leader>ng'] = {
			function()
				require'neogit'.open()
			end,
			'open neogit'
		}
	},

  v = {
    ['<leader>so'] = {
      function ()
        vim.notify('TODO: implement this function', vim.log.levels.INFO)
      end,
      '":source" visual selection'
    }
  }
}

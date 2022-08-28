local map = require "utils.map"

-- set <space> as the leader key
vim.g.mapleader = [[ ]]

map {
	i = {
		["kj"] = { "quickly leave insert mode",
			"<esc>",
		}
	},

	n = {
		["<leader>;"] = { "easily enter a command",
			":",
		},

		["<leader>h"] = { "search help docs",
      function() require("telescope.builtin").help_tags() end,
		},

		["<leader>w"] = { "write file",
			"<cmd> w <cr>",
		},

		["<leader>ff"] = { "fuzzy find files",
			function() require"telescope.builtin".find_files() end,
		},

		["<leader>c"] = { "search for a command",
      function() require("telescope.builtin").commands() end,
		},

		["<leader>ft"] = { "focus file tree",
			function()
				require("nvim-tree.api").tree.focus()
			end,
		},

		["<leader>ng"] = { "open neogit",
			function()
        require("neogit").open()
			end,
		}
	},

  v = {
    ["<leader>so"] = { "':source' visual selection",
      function ()
        vim.notify("TODO: implement this function", vim.log.levels.INFO)
      end,
    }
  }
}

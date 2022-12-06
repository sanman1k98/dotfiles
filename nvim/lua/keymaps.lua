local map = require "utils.map"

-- set <space> as the leader key
vim.g.mapleader = [[ ]]

map {
	i = {
		["kj"] = { desc = "quickly leave insert mode",
			"<esc>",
		}
	},

	n = {
		["<leader>;"] = { desc = "easily enter a command",
			":",
		},

		["<leader>h"] = { desc = "search help docs",
      function() require("telescope.builtin").help_tags() end,
		},

		["<leader>w"] = { desc = "write file",
			"<cmd> w <cr>",
		},

    ["<leader>e"] = { desc = "edit a file",
      ":e ",
    },

		["<leader>ff"] = { desc = "fuzzy find files",
			function() require"telescope.builtin".find_files() end,
		},

		["<leader>c"] = { desc = "search for a command",
      function() require("telescope.builtin").commands() end,
		},

		["<leader>ft"] = { desc = "focus file tree",
			function()
				require("nvim-tree.api").tree.focus()
			end,
		},

		["<leader>ng"] = { desc = "open neogit",
			function()
        require("neogit").open()
			end,
		},
    ["<leader>lc"] = { desc = "toggle displaying whitespace chars",
      function()
        vim.opt.list = not vim.opt.list:get()
      end,
    },
	},

  v = {
    ["<leader>so"] = { desc = "':source' visual selection",
      function ()
        vim.notify("TODO: implement this function")
      end,
    }
  }
}

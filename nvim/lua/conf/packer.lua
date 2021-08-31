-- plugin configurations loaded in init.lua

return require('packer').startup(
	function(use)

		-- load package manager
		use 'wbthomason/packer.nvim'

		-- load lspconfig
		use {
			'neovim/nvim-lspconfig',
			config = function () require'plugins.lsp' end
		}
		-- Dev setup for init.lua
		use 'folke/lua-dev.nvim'

		-- load autocomplete
		use {
			'hrsh7th/nvim-compe',
			config = require'plugins.compe'
		}

		-- treeshitter
		use {
			'nvim-treesitter/nvim-treesitter',
			config = require'plugins.treesitter'
		}

		-- load telescope fuzzy finder
		use {
			'nvim-telescope/telescope.nvim',
			requires = {
				{'nvim-lua/popup.nvim'},
				{'nvim-lua/plenary.nvim'}
			},
			config = require'plugins.telescope'
		}

		-- load which-key
		use {
			'folke/which-key.nvim',
			config = require'plugins.which-key'
		}

		use {
			'sudormrfbin/cheatsheet.nvim',
		}

		-- colorschemes
		use 'folke/tokyonight.nvim'

		-- statusline
		use {
			'hoob3rt/lualine.nvim',
			requires = {'kyazdani42/nvim-web-devicons', opt = true},
			config = require'plugins.lualine'
		}

	end)

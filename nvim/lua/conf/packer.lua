-- plugin configurations loaded in init.lua

return require('packer').startup(
	function(use)

		-- load package manager
		use 'wbthomason/packer.nvim'

		-- dependencies for some of the other plugins
		use 'nvim-lua/popup.nvim'
		use 'nvim-lua/plenary.nvim'



	end)


--[[

		-- colorschemes
		use 'folke/tokyonight.nvim'

		-- statusline
		use {
			'hoob3rt/lualine.nvim',
			requires = {'kyazdani42/nvim-web-devicons'},
			config = require'plugins.lualine'
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

		-- load lspconfig
		use {
			'neovim/nvim-lspconfig',
			config = function () require'plugins.lsp' end
		}
		-- Dev setup for init.lua
		use 'folke/lua-dev.nvim'

		-- load autocomplete
		use {
			'ms-jpq/coq_nvim',
			branch = 'coq',
			-- config = require''
		}

		-- snippets to go along with autocomplete
		use {
			'ms-jpq/coq.artifacts',
			branch = 'artifacts'
		}

		-- treeshitter
		use {
			'nvim-treesitter/nvim-treesitter',
			config = require'plugins.treesitter'
		}


		-- load which-key
		use {
		'folke/which-key.nvim',
		}

		use {
			'sudormrfbin/cheatsheet.nvim',
		}


]]--

-- plugin configurations loaded in init.lua

vim.fn.setenv('MACOSX_DEPLOYMENT_TARGET', '10.15')

return require('packer').startup(
	function(use)

		-- load package manager
		use 'wbthomason/packer.nvim'

		-- dependencies for some of the other plugins
		use 'nvim-lua/popup.nvim'
		use 'nvim-lua/plenary.nvim'

		-- telescope
		use 'nvim-telescope/telescope.nvim'

		-- colorschemes
		use 'folke/tokyonight.nvim'

		-- statusline
		use {
			'hoob3rt/lualine.nvim',
			requires = {'kyazdani42/nvim-web-devicons'},
			config = require'plugins.lualine'
		}

		-- treeshitter
		use {
			'nvim-treesitter/nvim-treesitter',
			branch = '0.5-compat',
			run = ':TSUpdate',
			config = require'plugins.treesitter'
		}

		-- load lspconfig
		use {
			'neovim/nvim-lspconfig',
			-- config = function () require'plugins.lsp' end
		}

		-- load autocomplete
		use {
			'ms-jpq/coq_nvim',
			branch = 'coq',
		}

		-- snippets to go along with autocomplete
		use {
			'ms-jpq/coq.artifacts',
			branch = 'artifacts'
		}

		-- coq settings here whatever
		vim.g.coq_settings = {
			['auto_start'] = 'shut-up'
		}

	end)

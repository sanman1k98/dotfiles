
local fn = vim.fn

-- some bootstrapping
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
	is_bootstrap = true
	fn.system {'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path}
end

vim.cmd.packadd 'packer.nvim'

-- packer.nvim iss180
fn.setenv('MACOSX_DEPLOYMENT_TARGET', '10.15')

return require('packer').startup(
	function(use)

		-- load package manager
		use 'wbthomason/packer.nvim'

		use 'nvim-lua/plenary.nvim'

		-- fancy notifications
		use {
			'rcarriga/nvim-notify',
			config = function() require'plugins.configs.notify' end
		}

		-- telescope
		use {
			'nvim-telescope/telescope.nvim',
			config = function () require'plugins.configs.telescope' end,
			module = 'telescope'
		}

		-- treeshitter
		use {
			'nvim-treesitter/nvim-treesitter',
			run = ':TSUpdate',
			config = function () require 'plugins.configs.treesitter' end,
		}

		-- colorschemes
		use {
			'folke/tokyonight.nvim',
			disable = true
		}
		use {
			'projekt0n/github-nvim-theme',
			module = 'github-theme',
		}
		use {
			'catppuccin/nvim', as = 'catppuccin',
			config = function() require'plugins.configs.theme' end
		}

		-- indentation guides
		use {
			event = 'BufReadPre',
			'lukas-reineke/indent-blankline.nvim',
			config = function ()
				local present, blankline = pcall(require, 'indent_blankline')
				if present then
					blankline.setup {
					show_first_indent_level = false,
					show_current_context = true,
					filetype_exclude = {'terminal', 'help', 'packer', 'man'},
					bufname_exclue = {'README.md'},
					show_end_of_line = true,
					space_char_blankline = ' '
				}
				end
			end
		}

		-- UI icons
		use {
			'kyazdani42/nvim-web-devicons',
			config = function() 
				local present, devicons = pcall(require, 'nvim-web-devicons')
				if present then
					devicons.setup()
				end
			end,
		}

		-- zen mode
		use {
			{
				'folke/twilight.nvim',
				module = 'twilight',
				config = function () require'twilight'.setup() end,
				disabled = true
			},
			{
				'folke/zen-mode.nvim',
				cmd = 'ZenMode',
				config = function () require'zen-mode'.setup() end,
				disabled = true
			}
		}

		-- status line
		use {
			'feline-nvim/feline.nvim',
			config = function() require'plugins.configs.statusline' end
		}

		-- git diffs

		use {
			'sindrets/diffview.nvim',
			module = 'diffview',
			config = function() require'plugins.configs.diffview' end
		}

		use {
			'TimUntersberger/neogit',
			module = 'neogit',
			config = function() require'plugins.configs.neogit' end
		}

		-- git signs in the number column
		use {
			'lewis6991/gitsigns.nvim',
			requires = { 'nvim-lua/plenary.nvim' },
			event = "BufReadPre",
			config = function()
				local present, gitsigns = pcall(require, 'gitsigns')
				if present then
					gitsigns.setup()
				end
			end,
		}

		-- file tree
		use {
			'kyazdani42/nvim-tree.lua',
			config = function () require'plugins.configs.tree' end,
			module = 'nvim-tree'
		}

		-- LSP related
		use {
			'neovim/nvim-lspconfig',
			requires = { 'hrsh7th/cmp-nvim-lsp' },
			event = "BufReadPre",
			config = function() require'plugins.configs.lsp' end,
		}

		use {
			'jose-elias-alvarez/null-ls.nvim',
			after = 'nvim-lspconfig',
			config = function() require'plugins.configs.null-ls' end,
		}

		use {
			'williamboman/mason-lspconfig.nvim', requires = { 'williamboman/mason.nvim' },
			after = 'nvim-lspconfig',
			config = function()
				local present1, mason = pcall(require, 'mason')
				local present2, mason_lspconfig = pcall(require, 'mason-lspconfig')
				if present1 and present2 then
					mason.setup()
					mason_lspconfig.setup()
				end
			end,
		}

		-- completion and snippets
		use {
			{
				'hrsh7th/nvim-cmp',
				event = { 'InsertEnter' },
				config = function() require 'plugins.configs.cmp' end,
			},
			{
				'L3MON4D3/LuaSnip',
				after = 'nvim-cmp',
				config = function() require 'plugins.configs.luasnip' end,
			},
			{'onsails/lspkind.nvim', after = 'nvim-cmp'},
			{'f3fora/cmp-spell', after = 'nvim-cmp'},
			{'hrsh7th/cmp-buffer', after = 'nvim-cmp'},
			{'hrsh7th/cmp-path', after = 'nvim-cmp'},
			{'hrsh7th/cmp-cmdline', after = 'nvim-cmp'},
			{'saadparwaiz1/cmp_luasnip', after = 'LuaSnip'},
			{'rafamadriz/friendly-snippets', after = 'LuaSnip'},
		}

		-- autopairs
		use {
			'windwp/nvim-autopairs',
			config = function () require'plugins.configs.autopairs' end,
			after = 'nvim-cmp'
		}

		use {
			'kylechui/nvim-surround',
			after = 'nvim-cmp',
			config = function () require'plugins.configs.surround' end,
		}

		if is_bootstrap then
			require('packer').sync()
		end

	end)

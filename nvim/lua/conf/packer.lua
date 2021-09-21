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

		-- treeshitter
		use {
			'nvim-treesitter/nvim-treesitter',
			branch = '0.5-compat',
			run = ':TSUpdate',
			config = function ()
				require'nvim-treesitter.configs'.setup {
					ensure_installed = 'maintained',
					highlight = {
						enable = true
					},
					indent = {
						enable = false
					}
				}
			end
		}

		use {
			'projekt0n/circles.nvim',
			requires = {'kyazdani42/nvim-web-devicons'},
			config = function () require'circles'.setup{} end
		}

		use {
			'hoob3rt/lualine.nvim',
			requires = {'projekt0n/circles.nvim'},
			config = function ()
				require'lualine'.setup {
					options = {
						theme = 'github'
					},
					sections = {
						lualine_x = {'encoding', 'filetype'}
					}
				}
			end
		}

		-- colorschemes
		use 'folke/tokyonight.nvim'
		use {
			'projekt0n/github-nvim-theme',
			config = function ()
				require'github-theme'.setup {
					theme_style = 'dark_default'
				}
			end
		}

		-- load lspconfig
		use {
			'neovim/nvim-lspconfig',
			config = function () require'plugins.lsp' end
		}

		-- load autocomplete and snippets
		use {
			'ms-jpq/coq_nvim',
			branch = 'coq',
		}
		use {
			'ms-jpq/coq.artifacts',
			branch = 'artifacts'
		}

		-- coq settings here whatever
		vim.g.coq_settings = {
			['auto_start'] = 'shut-up'
		}

	end)

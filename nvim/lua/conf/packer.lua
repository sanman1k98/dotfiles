--[[

For some stupid ass reason, :PackerSync doesn't work properly
Use the following when updating this file:
	1) save edits
	2) exit nvim
	3) start nvim
	4) :PackerUpdate
	5) :PackerSync

]]--

local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system {'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path}
	vim.cmd 'packadd packer.nvim'
end

-- packer.nvim iss180
fn.setenv('MACOSX_DEPLOYMENT_TARGET', '10.15')

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
					highlight = { enable = true },
					indent = { enable = false },
					autopairs = { enable = true }
				}
			end
		}

		-- M I N I M A L I S M
		use {
			'projekt0n/circles.nvim',
			requires = {'kyazdani42/nvim-web-devicons'},
			config = function () require'circles'.setup{} end
		}

		-- indentation guides
		use {
			'lukas-reineke/indent-blankline.nvim',
			config = function ()
				require'indent_blankline'.setup {show_current_context = true}
			end
		}

		-- zen mode
		use {
			{'folke/twilight.nvim', config = function () require'twilight'.setup() end},
			{'folke/zen-mode.nvim', config = function () require'zen-mode'.setup() end}
		}

		-- status line
		use {
			'hoob3rt/lualine.nvim',
			requires = {'projekt0n/circles.nvim'},
			config = function ()
				require'lualine'.setup {
					options = {
						theme = 'github'
					},
					sections = {
						lualine_x = {{'diagnostics', sources = {'nvim_lsp'}}, 'filetype'}
					}
				}
			end
		}

		-- file tree
		use {
			'kyazdani42/nvim-tree.lua',
			config = function () require'plugins.nvim-tree' end
		}

		-- colorschemes
		use 'folke/tokyonight.nvim'
		use {
			'projekt0n/github-nvim-theme',
			after = 'lualine.nvim',
			config = function ()
				require'github-theme'.setup {
					theme_style = 'dark_default',
					dark_sidebar = false,
					function_style = 'italic',
					variable_style = 'italic'
				}
			end
		}

		-- lspconfigs
		use {
			'neovim/nvim-lspconfig',
			config = function () require'plugins.lsp' end
		}

		-- TODO: find out how the hell this works cuz I'm dumb
		use {
			'jose-elias-alvarez/null-ls.nvim',
			config = function ()
				local nls = require'null-ls'
				nls.config {
					sources = {
						nls.builtins.formatting.prettier,
						nls.builtins.formatting.sylua
					}
				}
				require("lspconfig")["null-ls"].setup{}
			end
		}

		-- pretty diagnostics
		use {
			'folke/trouble.nvim',
			config = function () require'trouble'.setup{} end
		}

		-- autocomplete and snippets
		use {
			{ 'ms-jpq/coq_nvim', branch = 'coq' },
			{ 'ms-jpq/coq.artifacts', branch = 'artifacts' }
		}

		-- coq settings here whatever
		vim.g.coq_settings = {
			['auto_start'] = 'shut-up'
		}

		-- autopairs
		use {
			'windwp/nvim-autopairs',
			config = function () require'plugins.autopairs' end
		}

	end)


local fn = vim.fn

-- some bootstrapping
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
		use {
			'nvim-telescope/telescope.nvim',
			config = function ()
				local telescope = require'telescope'
				telescope.setup {
					pickers = {
						find_files = {
							find_command = {'fd', '--type', 'file', '--exclude', '{.git,node_modules}'},
							hidden = true
						},
						lsp_code_actions = {
							theme = 'cursor'
						}
					}
				}
			end,
			module = 'telescope'
		}
		-- treeshitter
		use {
			event = 'BufRead',
			module = 'telescope.previewers.buffer_preview',
			'nvim-treesitter/nvim-treesitter',
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

		-- indentation guides
		use {
			event = 'BufRead',
			'lukas-reineke/indent-blankline.nvim',
			config = function ()
				require'indent_blankline'.setup {
					show_current_context = true,
					filetype_exclude = {'terminal', 'help', 'packer', 'NvimTree', 'man'},
					bufname_exclue = {'README.md'},
				}
			end
		}

		-- M I N I M A L I S M
		use {
			'projekt0n/circles.nvim',
			requires = {'kyazdani42/nvim-web-devicons', opt = true},
			config = function () require'circles'.setup{} end
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
			'nvim-lualine/lualine.nvim',
			after = {
				'circles.nvim',
				'github-nvim-theme'
			},
			config = function ()
				require'lualine'.setup {
					options = {
						theme = 'auto'
					},
					sections = {
						lualine_x = {'filetype'}
					}
				}
			end
		}

		-- file tree
		use {
			'kyazdani42/nvim-tree.lua',
			config = function () require'nvim-tree'.setup{} end,
			module = 'nvim-tree'
		}

		-- file browser
		use {
			'nvim-telescope/telescope-file-browser.nvim',
			config = function ()
				require'telescope'.load_extension'file_browser'
			end
		}

		-- colorschemes
		use {
			'folke/tokyonight.nvim',
			opt = true,
			disabled = true
		}
		use {
			'projekt0n/github-nvim-theme',
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
			config = function () require'configs.lsp' end
		}

		-- TODO: find out how the hell this works cuz I'm dumb
		use {
			'jose-elias-alvarez/null-ls.nvim',
			after = 'nvim-lspconfig',
			config = function ()
				local nls = require'null-ls'
				nls.setup {
					sources = {
						nls.builtins.formatting.prettier.with {
							prefer_local = 'node_modules/.bin/'
						},
						nls.builtins.formatting.stylua
					}
				}
			end
		}

		-- pretty diagnostics
		use {
			'folke/trouble.nvim',
			config = function () require'trouble'.setup{} end,
			cmd = 'TroubleToggle'
		}

		-- coq settings here whatever
		vim.g.coq_settings = {
			['auto_start'] = 'shut-up'
		}

		-- autocomplete and snippets
		use {
			{ 'ms-jpq/coq_nvim', branch = 'coq' },
			{ 'ms-jpq/coq.artifacts', branch = 'artifacts' }
		}

		-- autopairs
		use {
			'windwp/nvim-autopairs',
			config = function () require'configs.autopairs' end
		}

	end)

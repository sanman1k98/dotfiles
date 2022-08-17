
local loaded, paq = pcall(require, "paq")

local plugins = {
  -- package manager
  "savq/paq-nvim",

  -- lodash.nvim
  "nvim-lua/plenary.nvim",

  -- fancy notifications
  "rcarriga/nvim-notify",

  -- TUI icons
  "kyazdani42/nvim-web-devicons",

  -- statusbar and winbar
  "feline-nvim/feline.nvim",
}

local opt_plugins = {
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    run = function() vim.cmd "TSUpdate" end
  },
  "nvim-treesitter/nvim-treesitter-textobjects",
  "nvim-treesitter/nvim-treesitter-context",

  -- fuzzy finder
  "nvim-telescope/telescope.nvim",

  -- manage terminal windows
  "akinsho/toggleterm.nvim",

  -- file tree
  "kyazdani42/nvim-tree.lua",

  -- git
  "TimUntersberger/neogit",
  "lewis6991/gitsigns.nvim",
  "sindrets/diffview.nvim",

  -- colorschemes
  { "catppuccin/nvim", as = "catppuccin" },
  "project0n/github-nvim-theme",
  "folke/tokyonight.nvim",

  -- indentation lines
  "lukas-reineke/indent-blankline.nvim",

  -- distraction free editing
  "folke/twilight.nvim",
  "folke/zen-mode.nvim",

  -- LSP
  "williamboman/mason.nvim",
  "neovim/nvim-lspconfig",
  "williamboman/mason-lspconfig.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  "glepnir/lspsaga.nvim",

  -- completion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "onsails/lspkind.nvim",
  "f3fora/cmp-spell",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",

  -- snippets
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",
  "saadparwaiz1/cmp_luasnip",

  -- autopairs and delimiters
  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",
	"kylechui/nvim-surround",

  -- comments
  "numToStr/Comment.nvim",

}

opt_plugins = vim.tbl_map(function(p)
  if type(p) == "string" then
    p = { p, opt = true }
  else
    p.opt = true
  end
end, opt_plugins)

vim.list_extend(plugins, opt_plugins)

if not loaded then
  require("bootstrap")(plugins)
end

paq(plugins):install()

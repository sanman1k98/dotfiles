local present, ts = pcall(require, 'nvim-treesitter.configs')

if not present then
  return
end

ts.setup {

  ensure_installed = {
    'lua'
  },
  -- automatically install parsers when entering buffer
  auto_install = true,

  highlight = { enable = true },

  -- can be enabled with ":TSBufEnable incremental_selection"
  incremental_selection = {
    enable = false,
    keymaps = { -- default keymaps
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

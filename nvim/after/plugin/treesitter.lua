
local loader = function()
  vim.cmd.packadd "nvim-treesitter"
  vim.cmd.packadd "nvim-treesitter-textobjects"
  vim.cmd.packadd "nvim-treesitter-context"

  local loaded1, ts = pcall(require, "nvim-treesitter.configs")
  if not loaded1 then
    return 
  end

  ts.setup {
    ensure_installed = {
      "lua",
    },
    auto_install = true,
    highlight = { enable = true },
    -- can be enabled with ":TSBufEnable incremental_selection"
    incremental_selection = {
      enable = true,
      keymaps = { -- default keymaps
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  }


  local loaded2, ts_context = pcall(require, "treesitter-context")
  if not loaded2 then
    return
  end

  ts_context.setup()
end

vim.api.nvim_create_autocmd("BufReadPre", {
  -- group = "syntaxset",
  callback = loader,
  once = true,
})

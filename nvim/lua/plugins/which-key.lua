local whichkey = {
  "folke/which-key.nvim",
  cmd = "WhichKey",
}

function whichkey.config()
  local wk = require "which-key"
  wk.setup {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
    },
    key_labels = {
      ["<leader>"] = "SPACE",
      ["<cr>"] = "RETURN",
      ["<tab>"] = "TAB",
    },
    show_help = false,
    show_keys = true,
    triggers_blacklist = {},
  }
end

return whichkey

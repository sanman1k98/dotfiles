return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  keys = require("util.map").lazykeys {  -- returns LazyKeys[]
    ["<leader>f"] = {
      name = "fuzzy",
      ["<cr>"] = { vim.cmd.Telescope, "Telescope builtin" },
      f = { function() require("telescope.builtin").find_files() end, "find files" },
      b = { function() require("telescope.builtin").buffers() end, "open buffers" },
      r = { function() require("telescope.builtin").reloader() end, "reload Lua modules" },
    },
    ["<leader>h"] = {
      name = "help",
      [";"] = { function() require("telescope.builtin").commands() end, "commands" },
      t = { function() require("telescope.builtin").help_tags() end, "search help tags" },
      k = { function() require("telescope.builtin").keymaps() end, "keymaps" },
      o = { function() require("telescope.builtin").vim_options() end, "search Vim options" },
    },
  },
  config = {
    -- TODO
  },
}

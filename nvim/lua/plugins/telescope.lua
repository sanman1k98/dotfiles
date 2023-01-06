return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  keys = require("util.map").lazykeys {  -- returns LazyKeys[]
    prefix = "<leader>f",
    name = "fuzzy",
    ["<cr>"] = { vim.cmd.Telescope, "Telescope builtin" },
    [";"] = { function() require("telescope.builtin").commands() end, "commands" },
    f = { function() require("telescope.builtin").find_files() end, "find files" },
    h = { function() require("telescope.builtin").help_tags() end, "search help tags" },
    b = { function() require("telescope.builtin").buffers() end, "open buffers" },
    r = { function() require("telescope.builtin").reloader() end, "reload Lua modules" },
    o = { function() require("telescope.builtin").vim_options() end, "search Vim options" },
    k = { function() require("telescope.builtin").keymaps() end, "keymaps" },
  },
  config = {
    -- TODO
  },
}

local util = require "util"
local map = util.map
local builtin = util.mod.defer "telescope.builtin"

map.normal {
  ["<leader>ff"] = { desc = "Find Files",
    function() builtin.find_files() end,
  },
  ["<leader>ht"] = { desc = "Help tags",
    function() builtin.help_tags() end,
  }
}

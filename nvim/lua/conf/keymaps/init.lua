local util = require "util"
local map = util.map
vim.o.timeoutlen = 300

local tele = util.load.mod "telescope.builtin"
local loaded_wk, wk = pcall(require, "which-key")

if loaded_wk then
  wk.register {
    ["<leader>t"] = { name = "+toggles" },
    ["<leader>f"] = { name = "+fuzzy" },
    ["<leader>."] = { name = "+config" },
  }
end

-- basic insert-mode mappings
map.insert {
  ["kj"] = "<esc>",
  ["<c-f>"] = "<right>",
  ["<c-b>"] = "<left>",
}

-- some shortcuts
map.normal({
  [";"] = { ":", "enter command-line" },
  ["w"] = { vim.cmd.write, "write file" },
  ["L"] = { vim.cmd.Lazy, "lazy.nvim"},
}, { prefix = "<leader>"})

-- config
map.normal({
  ["P"] = { desc = "Profile startup with Lazy",
    function() require("lazy.view.commands").commands["profile"]() end,
  }
}, { prefix = "<leader>."})

-- toggles
map.normal({
  ["lc"] = { desc = "list chars",
    function() vim.opt_local.list = not vim.opt_local.list:get() end,
  },
  ["e"] = { desc = "file explorer",
    "<cmd>Neotree toggle filesystem<cr>"
  },
  ["nc"] = { desc = "number column",
    function()
      local win_opt = vim.wo[0]
      local set = win_opt.number
      win_opt.number = not set
      win_opt.relativenumber = not set
    end,
  },
}, { prefix = "<leader>t"})

-- fuzzy
map.normal({
  ["<cr>"] = { vim.cmd.Telescope, "Telescope builtin" },
  ["f"] = { function() tele.find_files() end, "find files" },
  ["h"] = { function() tele.help_tags() end, "search help tags" },
  ["b"] = { function() tele.buffers() end, "open buffers" },
  [";"] = { function() tele.commands() end, "commands" },
  ["r"] = { function() tele.reloader() end, "reload Lua modules" },
  ["o"] = { function() tele.vim_options() end, "search Vim options" },
  ["k"] = { function() tele.keymaps() end, "keymaps" },
}, { prefix = "<leader>f" })

map.visual {
  ["<"] = { "<gv" },
  [">"] = { ">gv" },
}

map.mode.normal {
  ["<leader>"] = {
    h = {
      i = "<cmd>echo 'Hello!'",
    }
  }
}

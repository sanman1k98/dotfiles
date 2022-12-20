require "util.globals"

-- local projects
vim.opt.rtp:prepend "~/Projects/luauto.nvim"

require "core.options"
require "core.autocmds"
require "core.keymaps"

vim.cmd.colorscheme "cat_mocha"

local augroups = require "augroups"
local au = vim.api.nvim_create_autocmd
local packadd = vim.cmd.packadd



local lazy_load_telescope = function()
  packadd "telescope.nvim"
end

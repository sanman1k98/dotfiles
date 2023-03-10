
-- manually add to runtimepath
vim.opt.rtp:prepend(".")
vim.opt.rtp:prepend(vim.env.XDG_CONFIG_HOME.."/nvim/tests")
vim.opt.rtp:prepend(vim.env.XDG_DATA_HOME.."/nvim/lazy/plenary.nvim")


-- the `vim.cmd.runtime` call searches the runtimepath for a "plenary.vim"
-- plugin script and sources the first one that is found; creates the following
-- user commands:
--
--    - "PlenaryBustedFile"
--    - "PlenaryBustedDirectory"
--
vim.cmd.runtime "plugin/plenary.vim"

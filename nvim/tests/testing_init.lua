-- don't automatically load plugins
vim.opt.loadplugins = false

-- manually add to runtimepath
vim.cmd.packadd "plenary.nvim"


-- the `vim.cmd.runtime` call searches the runtimepath for a "plenary.vim"
-- plugin script and sources the first one that is found; creates the following
-- user commands:
--
--    - "PlenaryBustedFile"
--    - "PlenaryBustedDirectory"
--
vim.cmd.runtime "plugin/plenary.vim"


local user_commands = vim.api.nvim_get_commands { builtin = false }
if not user_commands.PlenaryBustedFile or not user_commands.PlenaryBustedDirectory then
  vim.notify("Plenary user commands not found", vim.log.levels.ERROR)
end


local loaded, busted = pcall(require, "plenary.busted")
if not loaded then
  vim.notify("Plenary not found", vim.log.levels.ERROR)
  return
end

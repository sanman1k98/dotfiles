local M = {}
local util = require "util"

M.module = package.loaded.packer

--- Return true if the `packer` module was able to be loaded.
function M.installed()
  if type(M.module) == "table" then
    return true
  end
  local loaded, mod = pcall(require, "packer")
  if loaded then
    M.module = mod
  else
    util.err(mod)
  end
  return loaded
end

-- allows for easier switching of configurations using git worktrees
local package_root = vim.fs.normalize "$XDG_CONFIG_HOME/nvim/pack"

-- clone 'packer.nvim', add it to the runtimepath, and set 'M.module'
local function get_packer()
  local install_path = package_root.."/packer/opt/packer.nvim"
  if vim.loop.fs_stat(install_path) then
    util.warn(("'%s' install directory already exists"):format(install_path))
    return false
  end
  vim.fn.system {
    "git",
    "clone",
    "--depth=1",
    "https://github.com/wbthomason/packer.nvim.git",
    install_path,
  }
  vim.cmd.packadd "packer.nvim"
  M.module = assert(require("packer"))
  return true
end

-- get packer, install plugins, and compile lazy-loaders
local function bootstrapper()
  get_packer()
  package.loaded.plugins = nil
  require "plugins"
  M.module.sync()
end

--- Prompts user with bootstrapping options. If running in headless mode, then
--- it goes through the whole bootstrap process.
function M.bootstrap()
  if util.is_headless() then
    require("luauto").cmd.User.PackerCompileDone(function()
      vim.cmd.quitall()
    end)
    bootstrapper()
  end
  vim.ui.select({
    "get 'packer.nvim' and sync all plugins",
    "get 'packer.nvim' only",
    "quit Neovim",
    "nothing (q)",
  },
  {
    prompt = "'packer.nvim' not found. What would you like to do?",
  }, function(choice, i)
    if i == 1 then
      bootstrapper()
      return
    elseif i == 2 then
      get_packer()
      return
    elseif i == 3 then
      vim.cmd.quitall()
    elseif i == 4 or not choice then
      return
    end
  end)
end

--- You can specify that Packer loads a plugin when requiring a module that
--- matches a given name or pattern. This post-install/update hook gets the
--- names of all the top-level modules in the plugin and adds a pattern for
--- each one found.
---@param plug table: a plugin spec
---@param disp table:
local function get_modnames(spec, disp)
  local dir = spec.install_path
  assert(vim.loop.fs_stat(dir), ("Expected '%s' at path: %s"):format(spec.short_name, dir))
  local has_lua = vim.loop.fs_stat(dir.."/lua")
  if has_lua then
    local pats = spec.module_pattern or {}  -- get the list of patterns or create empty list
    spec.module_pattern = pats              -- make sure that both reference the same list
    for f, t in vim.fs.dir(dir.."/lua") do
      if t == "directory" then table.insert(pats, "^"..vim.pesc(f))
      elseif t == "file" and f:sub(-4) == ".lua" then
        table.insert(pats, "^"..vim.pesc(f:sub(1, -5)))
      end
    end
  end
end

--- Custom key handler for a plugin spec's 'opt' key; adds a hook for all opt
--- plugins.
---@param arg1 table: global table of packer plugins
---@param arg2 table: a plugin spec
---@param arg3 any|nil: value of key in spec
local function handler(_, spec, opt)
  spec.opt = spec.start == true and false or opt
  -- conditions, when true, skip adding the post install hook
  if not opt or spec.disable then
    spec.module = nil
    spec.module_pattern = nil
    return
  elseif spec.module == false then
    spec.module = nil
    return
  elseif spec.module_pattern == false then
    spec.module_pattern = nil
    return
  end
  local ok, res = pcall(get_modnames, spec)
  if not ok then util.warn(res) end
  if type(spec.run) ~= "table" then
    spec.run = { spec.run }
  end
  table.insert(spec.run, get_modnames)
end

function M.configure()
  M.module.init {
    package_root = package_root,
    opt_default = true,
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
    profile = {
      enable = true,
      threshold = 1,
    },
  }
  M.module.set_handler("opt", handler)
end

function M.use(...)
  M.module.use(...)
end

return M

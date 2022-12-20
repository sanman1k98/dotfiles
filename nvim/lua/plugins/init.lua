local util = require "util"
local packer = util.packer

if packer.installed() then
  packer.configure()          -- calls packer.init() and sets handler
else
  return packer.bootstrap()   -- prompts user if not in headless mode
end

-- an iterator that returns loaders for submods in this dir
local function spec_loaders()
  return coroutine.wrap(function()
    local dir = vim.fs.dirname(debug.getinfo(1, "S").source:sub(2))   -- get this file's parent
    for f, t in vim.fs.dir(dir) do
      if t == "file" and vim.endswith(f, ".lua") and f ~= "init.lua" then
        coroutine.yield(loadfile(dir.."/"..f))
      elseif t == "directory" then
        local subdir = dir.."/"..f
        for subf, subt in vim.fs.dir(subdir) do
          if subt == "file" and subf == "init.lua" then
            coroutine.yield(loadfile(subdir.."/init.lua"))
          end
        end
      end
    end
  end)
end

local plugins = {
  "wbthomason/packer.nvim",
  "nvim-lua/plenary.nvim",
  "kyazdani42/nvim-web-devicons",
}

for loader, err in spec_loaders() do
  if not loader then util.err(err)    -- notify compilation error
  else
    local ok, spec = pcall(loader)
    if not ok then util.err(spec)     -- notify runtime error
    elseif vim.tbl_islist(spec) then
      vim.list_extend(plugins, spec)  -- add list of plugins
    else
      table.insert(plugins, spec)     -- add single plugin
    end
  end
end

packer.use(plugins)

local util = require "util"
local notify = require "util.notify"

---@class KittyUtility
local M = {}

--- Returns path to the directory that contains the kitty configuration file.
---@private
function M._get_kitty_config_dir()
  return vim.env.XDG_CONFIG_HOME.."/kitty"
end

M.config = {
  themes_dir = M._get_kitty_config_dir().."/themes"
}

M.did_setup = false

-- TODO: use socket directly instead of the `kitty` CLI
function M.backend()
end

---@param args string[]
function M.cmd(args)
  return vim.fn.system({
    "kitty",
    unpack(args)
  })
end

---@param opts? table
function M.setup(opts)
  if M.did_setup then return end
  if not util.has("kitty") then
    return notify.err [[
      # `util.kitty`
      "kitty" executable not found.
    ]]
  end
  if opts then util.merge(M.config, opts) end
  M._id = util.autocmd.ColorScheme(function(e)
    M.theme(e.match)
  end, { desc = "set kitty colors to match nvim colorscheme" })
  M.did_setup = true
end

---@param cmd string
---@param args string[]
function M.ctl(cmd, args)
  return M.cmd({
    "@",
    cmd,
    unpack(args)
  })
end

--- Set colors using the file with a ".conf" extension located in
--- `config.themes_dir`.
---@param name string
function M.theme(name)
  M.ctl("set-colors", {
    (M.config.themes_dir.."/%s.conf"):format(name),
  })
end

--- Call a kitten with arguments.
---@param name string
---@param args string[]
function M.kitten(name, args)
  return M.cmd({
    "+kitten",
    name,
    unpack(args)
  })
end

local zoomed = false

function M.toggle_zoom()
  if zoomed then
    M.ctl("set-spacing", { "padding=default" })
    M.ctl("set-font-size", { "0" })
  else
    M.ctl("set-font-size", { "+4" })
    M.ctl("set-spacing", { "padding=60" })
  end
  zoomed = not zoomed
end

return M

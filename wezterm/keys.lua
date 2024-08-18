local act = wezterm.action

-- Modifiers "WIN", "CMD", and "SUPER" are equivalent.
-- Modifiers "ALT", "OPT", and "META" are equivalent.
local M = {}

M.shared_keys = {
  { key = "UpArrow", mods = "SHIFT", action = act.ScrollToPrompt(-1) },
  { key = "DownArrow", mods = "SHIFT", action = act.ScrollToPrompt(1) },
}

-- Common macOS keyboard shortcuts.
M.macos_keys = {
  { key = "LeftArrow", mods = "CMD", action = act.SendKey { key = "Home" } },
  { key = "RightArrow", mods = "CMD", action = act.SendKey { key = "End" } },
  { key = "LeftArrow", mods = "OPT", action = act.SendKey { key = "b", mods = "META" } },
  { key = "RightArrow", mods = "OPT", action = act.SendKey { key = "f", mods = "META" } },
}

local mac = wezterm.target_triple:find("apple%-darwin$")

---@param config config
function M.setup(config)
  config.enable_kitty_keyboard = true
  config.keys = M.shared_keys

  -- Append to list
  if mac then
    for _, k in ipairs(M.macos_keys) do
      table.insert(config.keys, k)
    end
  end
end

return M

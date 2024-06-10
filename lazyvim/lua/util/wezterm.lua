local M = {}

M.is_wezterm = vim.env.TERM == "wezterm"

---@param key string
---@param value string
function M.set_user_var(key, value)
  io.write(string.format("\027]1337;SetUserVar=%s=%s\a", key, vim.base64.encode(value)))
end

return M

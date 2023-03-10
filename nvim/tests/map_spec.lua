local map = require "util.map"
map.defer = false

---@param mode string
---@param lhs string
---@return table
local function get_keymap(mode, lhs)
  local t = vim.fn.maparg(lhs, mode, false, true)
  return not vim.tbl_isempty(t) and t or nil
end

describe("map.set", function()
  before_each(vim.cmd.mapclear)

  it("can set normal mode mappings", function()
    map.set({
      hi = { "<cmd>echo 'hi'<cr>" },
      so = { "<cmd>source<cr>" },
    })
    assert.is.truthy(get_keymap("n", "hi"))
    assert.is.truthy(get_keymap("n", "so"))
  end)
end)

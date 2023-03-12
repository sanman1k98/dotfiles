local map = require "util.map"
map.defer = false

require "tests.assertions"

---@param mode string
---@param lhs string
---@return table
local function get_keymap(mode, lhs)
  local t = vim.fn.maparg(lhs, mode, false, true)
  return not vim.tbl_isempty(t) and t or nil
end

describe("map.set()", function()
  before_each(vim.cmd.mapclear)

  it("can set normal mode mappings", function()
    map.set({
      hi = { "<cmd>echo 'hi'<cr>" },
      so = { "<cmd>source<cr>" },
    })
    assert.is.truthy(get_keymap("n", "hi"))
    assert.is.truthy(get_keymap("n", "so"))
  end)

  it("can set insert mode mappings", function()
    map.set({
      mode = "i",
      kj = { "<esc>" },
    })
    assert.is.truthy(get_keymap("i", "kj"))
  end)

  it("can set mappings with a common prefix", function()
    map.set({
      prefix = "<leader>",
      ["1"] = { "<cmd>echo 'one'<cr>" },
      ["2"] = { "<cmd>echo 'two'<cr>" },
      ["3"] = { "<cmd>echo 'three'<cr>" },
    })
    assert.is.truthy(get_keymap("n", "<leader>1"))
    assert.is.truthy(get_keymap("n", "<leader>2"))
    assert.is.truthy(get_keymap("n", "<leader>3"))
  end)

  it("can set mappings with a nested table", function()
    map.set({
      h = {
        e = {
          y = { "<cmd>echo 'hey'<cr>" },
        },
        i = { "<cmd>echo 'hi'<cr>" },
      },
    })
    assert.is.truthy(get_keymap("n", "hi"))
    assert.is.truthy(get_keymap("n", "hey"))
  end)

  pending("can set mappings with common options")

  pending("can set mappings with descriptions")

  pending("supports 'which-key' group names")
end)

describe("map.lazykeys()", function()
  it("returns a list of 'LazyKeys'", function()
    local values = {
      { "hi", "<cmd>echo 'hi'<cr>", mode = "n" },
      { "so", "<cmd>source<cr>", mode = "n" },
    }
    local list = map.lazykeys({
      hi = { "<cmd>echo 'hi'<cr>" },
      so = { "<cmd>source<cr>" },
    })
    assert.contains(list, values)
  end)
end)

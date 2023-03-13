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

describe("map.process_tree()", function()
  it("returns a list of mapargs to set mappings", function()
    local mappings = {
      hi = { "<cmd>echo 'hi'<cr>" },
      so = { "<cmd>source<cr>" },
    }
    local values = {
      { "n", "hi", "<cmd>echo 'hi'<cr>", { --[[ empty opts table ]] } },
      { "n", "so", "<cmd>source<cr>", { --[[ empty opts table ]] } },
    }
    assert.contains(map.process_tree(mappings), values)
  end)

  it("returns a list of mapargs with a common lhs prefix", function()
    local mappings = {
      prefix = "h",
      i = { "<cmd>echo 'hi'<cr>" },
      a = { "<cmd>echo 'ha'<cr>" },
      e = { "<cmd>echo 'he'<cr>" },
    }
    local values = {
      { "n", "hi", "<cmd>echo 'hi'<cr>", { --[[ empty opts table ]] } },
      { "n", "ha", "<cmd>echo 'ha'<cr>", { --[[ empty opts table ]] } },
      { "n", "he", "<cmd>echo 'he'<cr>", { --[[ empty opts table ]] } },
    }
    assert.contains(map.process_tree(mappings), values)
  end)

  it("returns a list of mapargs with options specified in root of tree", function()
    local mappings = {
      silent = true,
      buffer = true,
      hi = { "<cmd>echo 'hi'<cr>" },
      so = { "<cmd>source<cr>" },
    }
    local values = {
      { "n", "hi", "<cmd>echo 'hi'<cr>", { silent = true, buffer = true } },
      { "n", "so", "<cmd>source<cr>", { silent = true, buffer = true } },
    }
    assert.contains(map.process_tree(mappings), values)
  end)

  it("can have options specified in a subtree", function()
    local mappings = {
      h = {
        silent = false,
        i = { "<cmd>echo 'hi'<cr>" },
        a = { "<cmd>echo 'ha'<cr>" },
        e = { "<cmd>echo 'he'<cr>" },
      },
      so = { "<cmd>source<cr>" },
    }
    local values = {
      { "n", "hi", "<cmd>echo 'hi'<cr>", { silent = false } },
      { "n", "ha", "<cmd>echo 'ha'<cr>", { silent = false } },
      { "n", "he", "<cmd>echo 'he'<cr>", { silent = false } },
      { "n", "so", "<cmd>source<cr>", {} },
    }
    assert.contains(map.process_tree(mappings), values)
  end)

  it("supports an extra 'cond' option for mappings", function()
    local mappings = {
      say = { "<cmd>echo '2 + 2 = fish'<cr>", cond = (2 + 2 == "fish") },
      hi = { "<cmd>echo 'hi'<cr>", cond = true },
      ha = { "<cmd>echo 'ha'<cr>", cond = "happy" },
      he = { "<cmd>echo 'he'<cr>", cond = nil },
    }
    local values = {
      { "n", "hi", "<cmd>echo 'hi'<cr>", {} },
      { "n", "ha", "<cmd>echo 'ha'<cr>", {} },
      { "n", "he", "<cmd>echo 'he'<cr>", {} },
    }
    assert.contains(map.process_tree(mappings), values)
  end)

  it("supports a 'cond' option for subtrees", function()
    local mappings = {
      h = {
        cond = false,
        i = { "<cmd>echo 'hi'<cr>" },
        a = { "<cmd>echo 'ha'<cr>" },
        e = { "<cmd>echo 'he'<cr>" },
      },
      so = { "<cmd>source<cr>" },
    }
    local values = {
      { "n", "so", "<cmd>source<cr>", {} },
    }
    assert.contains(map.process_tree(mappings), values)
  end)
end)

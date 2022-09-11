local mock = require "luassert.mock"
local stub = require "luassert.stub"

local print = vim.pretty_print


describe("Builtin keymap APIs", function()
  local test_leader = " "
  local test_mode = "n"
  local test_lhs = "<leader>hi"
  local test_rhs = function() vim.notify "Hello!" end

  it("Sets the global map leader key as <space>", function()
    vim.g.mapleader = test_leader
  end)

  it("Gets all the normal mode keymappings", function()
    local mapargs = vim.api.nvim_get_keymap(test_mode)
    print(mapargs)
  end)

  it("Sets a keymapping that displays \"Hello!\"", function()
    vim.keymap.set(test_mode, test_lhs, test_rhs)
  end)

  it("Gets a normal mode keymapping", function()
    local keymap = vim.fn.maparg(test_lhs, test_mode, false, true)
    print(keymap)
  end)

  it("Deletes a keymapping from normal mode", function()
    vim.keymap.del(test_mode, test_lhs)
  end)

end)

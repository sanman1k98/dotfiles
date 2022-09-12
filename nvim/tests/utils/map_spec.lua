local mock = require "luassert.mock"
local stub = require "luassert.stub"

local print = vim.pretty_print


describe("Demonstrate builtin keymap APIs", function()
  local test_leader = " "
  local test_mode = "n"
  local test_lhs = "<leader>hi"
  local test_rhs = function() vim.notify "Hello!" end

  it("gets all the normal mode keymappings", function()
    local mapargs = vim.api.nvim_get_keymap(test_mode)
    assert.is_true(vim.tbl_islist(mapargs))
  end)

  pending("gets Neovim's default keymappings", function()
    local mapargs = vim.api.nvim_get_keymap("n")
    local nvim_default_mappings = {}
    for _, mapping in ipairs(mapargs) do
      if mapping.desc == "Nvim builtin" then
        table.insert(nvim_default_mappings, mapping)
      end
    end
  end)

  it("sets the global map leader key as <space>", function()
    vim.g.mapleader = test_leader
  end)

  it("sets a keymapping that displays \"Hello!\"", function()
    vim.keymap.set(test_mode, test_lhs, test_rhs)
  end)

  it("gets a normal mode keymapping", function()
    local is_abbrv, return_dict = false, true
    local keymap = vim.fn.maparg(test_lhs, test_mode, is_abbrv, return_dict)
    assert.is_not_true(vim.tbl_isempty(keymap))
  end)

  it("deletes a keymapping from normal mode", function()
    vim.keymap.del(test_mode, test_lhs)
  end)

end)

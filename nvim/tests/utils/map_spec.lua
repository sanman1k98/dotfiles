local mock = require "luassert.mock"
local stub = require "luassert.stub"

local print = vim.pretty_print

describe("Neovim's builtin API and `vim` module", function()
  local test_leader = " "
  local test_keymap = {
    mode = "n",
    lhs = "<leader>hi",
    rhs = function() vim.notify "Hello!" end,
  }

  it("gets all the normal mode keymappings maparg-like dicts", function()
    local mapargs = vim.api.nvim_get_keymap("n")
    assert.is_true(vim.tbl_islist(mapargs))
  end)

  it("gets Neovim's default keymappings from a list of maparg-like dicts", function()
    local mapargs = vim.api.nvim_get_keymap("")
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
    vim.keymap.set(test_keymap.mode, test_keymap.lhs, test_keymap.rhs)
  end)

  it("gets the new keymapping that was just set", function()
    local is_abbrv, return_dict = false, true
    local keymap = vim.fn.maparg(
      test_keymap.lhs,
      test_keymap.mode,
      is_abbrv,
      return_dict)
    assert.is_not_true(vim.tbl_isempty(keymap))
  end)

  it("deletes the new keymapping", function()
    vim.keymap.del(test_keymap.mode, test_keymap.lhs)
  end)

  it("returns an empty dict for a mapping that does not exist anymore", function()
    local is_abbrv, return_dict = false, true
    local keymap = vim.fn.maparg(
      test_keymap.lhs,
      test_keymap.mode,
      is_abbrv,
      return_dict)
    assert.is_true(vim.tbl_isempty(keymap))
  end)
end)


describe("User `utils.map` module", function()
  local map = require "utils.map"

  local test_definitions = {
    n = {
      ["<leader>hi"] = { desc = "salutations",
        function() vim.notify "Hello!" end
      },
      ["<leader>bb"] = { desc = "parting words",
        function()
          vim.notify "Goodbye!"
          vim.defer_fn(function()
            vim.cmd "qa"
          end, 5000)
        end
      },
      ["<leader>w"] = { desc = "write file",
        function() vim.cmd.write() end
      },
      ["<leader>so"] = { desc = "source current file",
        function()
          vim.cmd.source()
          vim.notify("Sourced " .. vim.api.nvim_buf_get_name(0))
        end
      },
    },
    i = {
      ["kj"] = { desc = "shortcut to normal mode",
        "<esc>"
      },
    },
    v = {
      ["<leader>so"] = { desc = "source selection",
        function()
          vim.cmd.source { range = { "'<", "'>" } }
          vim.notify "Sourced selection"
        end
      }
    }
  }

  describe("provides", function()
    it("an iterator to traverse a table of mapping definitions", function()
      assert.is_not_falsy(map.args)
      assert.is_true(type(map.args) == "function")
    end)

    it("a function to validate a table of mapping definitions", function()
      assert.is_not_falsy(map.validate)
      assert.is_true(type(map.validate) == "function")
    end)

    it("a function to set mappings", function()
      assert.is_not_falsy(map.set)
      assert.is_true(type(map.set) == "function")
    end)

    it("a function to delete mappings", function()
      assert.is_not_falsy(map.del)
      assert.is_true(type(map.del) == "function")
    end)
  end)

  describe("traverses", function()
    it("and returns arguments for `vim.keymap.set`", function()
      local args_list = {}
      for mode, lhs, rhs, opts in map.args(test_definitions) do
        table.insert(args_list, {
          mode = mode,
          lhs = lhs,
          rhs = rhs,
          opts = opts
        })
      end
      for _, args in ipairs(args_list) do
        assert.has_no.errors(function()
          vim.validate {  -- copied from `vim.keymap.set`
            mode = { args.mode, { 's', 't' } },
            lhs = { args.lhs, 's' },
            rhs = { args.rhs, { 's', 'f' } },
            opts = { args.opts, 't', true },
          }
        end)
      end
    end)
  end)

  describe("validates", function()
    pending("a table of mapping definitions", function()
    end)

    pending("a single mapping definition", function()
    end)

    it("a mapping's info", function()
      local info = { desc = "parting words",
        function()
          vim.notify "Goodbye!"
          vim.defer_fn(function()
            vim.cmd "qa"
          end, 5000)
        end
      }
      assert.has_no.errors(function()
        map.validate_info(info)
      end)
      local bad_info = { -- must contain a "desc" field
        "<leader>bad"
      }
      assert.has_errors(function()
        map.validate_info(bad_info)
      end)
    end)
  end)

  describe("sets", function()
    it("a single mapping", function()
      -- order in which indices are enumerated is not specified
      local mode = next(test_definitions)              -- returns an index: a mode short name
      local lhs, info = next(test_definitions[mode])   -- returns an index and its associated value: an lhs and its info
      assert.has_no.errors(function()
        map.set { [mode] = { [lhs] = info } }
      end)
      local new_mapping = vim.fn.maparg(lhs, mode, false, true)
      assert.is_not_true(vim.tbl_isempty(new_mapping))
    end)

    pending("multiple mappings", function()
    end)

    pending("the rest of the mappings even if the first one failed", function()
    end)
  end)

  describe("deletes", function()
    pending("a single mapping", function()
    end)

    pending("multiple mappings", function()
    end)
  end)

  describe("errors", function()
    pending("when validating an invalid table of mappings", function()
    end)

    pending("another situation that should error", function()
    end)

    pending("yet another situation that should error", function()
    end)
  end)

  pending("is itself callable and can also set mappings", function()
  end)

end)

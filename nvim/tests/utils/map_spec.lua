local mock = require "luassert.mock"
local stub = require "luassert.stub"
local spy = require "luassert.spy"
local match = require "luassert.match"

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

  local test_mode = next(test_definitions)
  local test_lhs, test_info = next(test_definitions[test_mode])
  local test_single_definition = {
    [test_mode] = {
      [test_lhs] = test_info
    }
  }

  describe("provides", function()
    it("iterators to traverse a table of mapping definitions", function()
      assert.is_not_falsy(map.args)
      assert.is_true(type(map.args) == "function")
      assert.is_not_falsy(map.iter)
      assert.is_true(type(map.iter) == "function")
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
    pending("and returns the mode, lhs, and information for each mapping", function()
    end)
    
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

    pending("and returns arguments for `vim.keymap.set` that contain the buffer specified", function()
    end)
  end)

  describe("sets", function()
    it("a single mapping", function()
      assert.has_no.errors(function()
        map.set(test_single_definition)
      end)
      local new_mapping = vim.fn.maparg(test_lhs, test_mode, false, true)
      assert.is_not_true(vim.tbl_isempty(new_mapping))
    end)

    it("multiple mappings", function()
      assert.has_no_errors(function()
        map.set(test_definitions)
      end)
    end)

    it("the rest of the mappings even if the first one failed", function()
      local first_def_bad = {
        n = {
          ["<leader>a"] = { dsec = "misspelled field name for a string description",
            function()
            end
          },
          ["<leader>s"] = { desc = "should be set even after the first one errored",
            function()
            end
          },
          ["<leader>d"] = { desc = "should also be set",
            function()
            end
          },
        }
      }
      local s = spy.on(vim, "notify")
      assert.has_no.errors(function()
        map.set(first_def_bad)
      end)
      assert.spy(s).was_called_with(match.is_string(), vim.log.levels.ERROR)
      vim.notify:revert()
      local first_mapping = vim.fn.maparg("<leader>a", "n", false, true)
      local second_mapping = vim.fn.maparg("<leader>s", "n", false, true)
      local third_mapping = vim.fn.maparg("<leader>d", "n", false, true)
      assert.is_true(vim.tbl_isempty(first_mapping))
      assert.is_not_true(vim.tbl_isempty(second_mapping))
      assert.is_not_true(vim.tbl_isempty(third_mapping))
    end)

    pending("and warns when a mapping does not have a description", function()
    end)

    pending("buffer local mappings", function()
    end)
  end)

  describe("deletes", function()
    pending("a single mapping", function()
    end)

    pending("multiple mappings", function()
    end)

    pending("buffer-local mappings", function()
    end)
  end)

  pending("is itself callable and can also set mappings", function()
  end)

end)

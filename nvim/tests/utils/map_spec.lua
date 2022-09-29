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
    describe("a table representing mapping modes", function()
      it("which when iterated using `ipairs` returns seven map command prefixes", function()
        local count = 0
        for _, v in ipairs(map.modes) do
          assert.is_true(type(v) == "string")
          assert.are_equal(#v, 1)
          count = count + 1
        end
        assert.are_equal(#map.modes, 7)
        assert.are_equal(count, 7)
      end)

      it("which can be iterated using `pairs`", function()
        local count = 0
        for _, v in pairs(map.modes) do
          assert.is_true(type(v) == "string")
          assert.are_equal(#v, 1)
          count = count + 1
        end
        assert.are_equal(#map.modes, 7)
        assert.are_equal(count, 7)
      end)

      it("indexable by name and returns the associated map command prefix", function()
        assert.are_equal(map.modes.normal, "n")
        assert.are_equal(map.modes.select, "s")
        assert.are_equal(map.modes.visual, "x")
        assert.are_equal(map.modes.operator_pending, "o")
        assert.are_equal(map.modes.insert, "i")
        assert.are_equal(map.modes.command_line, "c")
        assert.are_equal(map.modes.terminal, "t")
      end)

      it("indexable by map command prefix and returns itself", function()
        assert.are_equal(map.modes.n, "n")
        assert.are_equal(map.modes.s, "s")
        assert.are_equal(map.modes.x, "x")
        assert.are_equal(map.modes.o, "o")
        assert.are_equal(map.modes.i, "i")
        assert.are_equal(map.modes.c, "c")
        assert.are_equal(map.modes.t, "t")
      end)

      it("and can be indexed by map command prefixes like 'v' or '!' which returns a list of modes", function()
        assert.is_true(vim.tbl_islist(map.modes[""]))
        for _, m in ipairs(map.modes[""]) do
          assert.is_true(type(m) == "string" and #m <= 1)
          assert.is_true(vim.tbl_contains(map.modes, m))
        end
        assert.is_true(vim.tbl_islist(map.modes["v"]))
        for _, m in ipairs(map.modes["v"]) do
          assert.is_true(type(m) == "string" and #m <= 1)
          assert.is_true(vim.tbl_contains(map.modes, m))
        end
        assert.is_true(vim.tbl_islist(map.modes["!"]))
        for _, m in ipairs(map.modes["!"]) do
          assert.is_true(type(m) == "string" and #m <= 1)
          assert.is_true(vim.tbl_contains(map.modes, m))
        end
      end)

      pending("which is read-only", function()
      end)
    end)

    describe("iterators", function()
      it("that returns the mode, lhs, and info given a table containing mapping information", function()
        assert.is_not_falsy(map.iter)
        assert.is_true(type(map.iter) == "function")
      end)

      it("that return arguments to `vim.keymap.set` given a table containing mapping information", function()
        assert.is_not_falsy(map.args)
        assert.is_true(type(map.args) == "function")
      end)

      it("that returns the modes from a table", function()
        assert.is_not_falsy(map.modes)
        assert.is_true(vim.is_callable(map.modes))
      end)
    end)

    it("iterators to traverse a table of mapping definitions", function()
      assert.is_not_falsy(map.args)
      assert.is_true(type(map.args) == "function")
      assert.is_not_falsy(map.iter)
      assert.is_true(type(map.iter) == "function")
    end)

    it("a function to get mappings", function()
      assert.is_not_falsy(map.get)
      assert.is_true(type(map.get) == "function")
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
    describe("by calling `map.modes` as a function in a generic for-loop", function()
      it("through a list of modes", function()
        local modes = {}
        local count = 0
        for m in map.modes(map.modes) do
          count = count + 1
          table.insert(modes, m)
        end
        assert.are_equal(#map.modes, count)
        assert.are_same(map.modes, modes)
      end)
    end)

    it("and returns the mode, lhs, and information for each mapping", function()
      for mode, lhs, info in map.iter(test_definitions) do
        assert.has_no_errors(function()
          vim.validate {
            mode = { mode, "s" },
            lhs = { lhs, "s" },
            info = { info, "t" },
          }
        end)
      end
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

    it("and returns arguments for `vim.keymap.set` that contain the buffer specified", function()
      local buf_local= {
        normal = {
          ["<leader>"] = { desc = "toggle the `list` option",
            function()
              vim.opt.list = not vim.opt.list:get()
            end,
            buffer = true,
          }
        }
      }
      for _, _, _, opts in map.args(buf_local) do
        assert.is_true(opts.buffer)
      end
    end)

    it("through a list of 'maparg()-like' dictionaries and returns the mode, lhs, and info", function()
      local mappings = vim.api.nvim_get_keymap("n")
      for mode, lhs, info in map.iter(mappings) do
        assert.has_no_errors(function()
          vim.validate {
            mode = { mode, "s" },
            lhs = { lhs, "s" },
            info = { info, "t" },
          }
        end)
      end
    end)

    it("through lists of multiple lhs in various modes", function()
      local tbl = {}
      do  -- create the list of strings representing lhs for each mode
        for mode, lhs in map.iter(test_definitions) do
          local m = tbl[mode] or {}
          table.insert(m, lhs)
        end
        for _, mappings in pairs(tbl) do
          assert.is_true(vim.tbl_islist(mappings))
          for _, lhs in ipairs(mappings) do
            assert.is_true(type(lhs) == "string")
          end
        end
      end
      for mode, lhs in map.iter(tbl) do
        assert.is_true(type(lhs) == "string")
      end
    end)
  end)

  describe("gets", function()
    it("a single mapping given a mode and lhs", function()
      local builtin = vim.api.nvim_get_keymap("")[1]
      assert.are_equal(builtin.desc, "Nvim builtin")
      local mappings = map.get { [builtin.mode] = { builtin.lhs } }
      assert.is_not_true(vim.tbl_isempty(mappings))
      assert.is_true(vim.tbl_islist(mappings))
      assert.are_equal(1, #mappings)
      local mapping = mappings[1]
      assert.are_same(mapping, builtin)
    end)

    it("mappings from a list containing a single mode", function()
      local builtin = vim.api.nvim_get_keymap("")
      local mappings = map.get { "" }
      assert.are_same(builtin, mappings)
    end)

    it("mappings from multiple modes", function()
      local mappings = map.get(map.modes)
      assert.is_not_true(vim.tbl_isempty(mappings))
      assert.is_true(vim.tbl_islist(mappings))
    end)

    it("mappings given the same table used to set them", function()
      assert.has_no.errors(function()
        map.set(test_single_definition)
      end)
      local mapping = map.get(test_single_definition)
      assert.is_not_true(vim.tbl_isempty(mapping))
      assert.is_true(vim.tbl_islist(mapping))
      assert.are_equal(test_mode, mapping[1].mode)
      assert.are_equal(vim.api.nvim_replace_termcodes(test_lhs, true, true, true), mapping[1].lhs)
      vim.keymap.del(test_mode, test_lhs)
    end)

    it("buffer-local mappings", function()
      local mapargs = vim.api.nvim_buf_get_keymap(0, "")
      local mappings = map.get({ "" }, true)
      assert.are_equal(#mapargs, #mappings)
    end)
  end)

  describe("sets", function()
    it("a single mapping", function()
      assert.has_no.errors(function()
        map.set(test_single_definition)
      end)
      local new_mapping = map.get(test_single_definition)
      assert.is_not_true(vim.tbl_isempty(new_mapping))
    end)

    it("multiple mappings", function()
      assert.has_no_errors(function()
        map.set(test_definitions)
      end)
      local mappings = map.get(test_definitions)
      assert.is_not_true(vim.tbl_isempty(mappings))
    end)

    it("the rest of the mappings even if the first one failed", function()
      local first_def_bad = {
        n = {
          ["<leader>a"] = { desc = "doesn't define an rhs!", },
          ["<leader>s"] = { desc = "should be set even after the first one errored",
            function() end
          },
          ["<leader>d"] = { desc = "should also be set",
            function() end
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
      local mappings = map.get(first_def_bad)
      assert.is_not_true(vim.tbl_isempty(mappings))
      assert.are_equal(#mappings, 2)
    end)

    it("and warns when a mapping does not have a description", function()
      local notify = stub(vim, "notify")
      map.set {
        n = {
          ["<leader>a"] = { -- no "desc" field
            function() end
          },
        }
      }
      assert.stub(notify).was_called_with(match.is_string(), vim.log.levels.WARN)
      local mapping = vim.fn.maparg("<leader>a", "n", false, true)
      assert.is_not_true(vim.tbl_isempty(mapping))
    end)

    it("buffer local mappings", function()
      map.set(test_definitions, true)       -- `true` for the current buffer
      local mappings = map.get(test_definitions, 0)    -- "0" for the current buffer
      assert.is_not_true(vim.tbl_isempty(mappings))
      local definitions_size = map.count(test_definitions)
      assert.are_equal(definitions_size, #mappings)
    end)
  end)

  describe("deletes", function()
    it("a single mapping", function()
      local mapping = map.get(test_single_definition)
      assert.are_not_same(mapping, {})
      assert.are_equal(#mapping, 1)
      assert.has_no_errors(function()
        map.del(test_single_definition)
      end)
      mapping = map.get(test_single_definition)
      assert.are_same(mapping, {})
    end)

    pending("multiple mappings", function()
    end)

    pending("buffer-local mappings", function()
    end)

    pending("mappings given the table used to set them in the first place", function()
    end)
  end)

  pending("is itself callable and can also set mappings", function()
  end)

end)

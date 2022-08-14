local present1, lsp = pcall(require, 'lspconfig')
local present2, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')

if not (present1 or present2) then
	return
end

local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

local attach_fn = function(_, bufnr)
	local map = require'utils.map'
	local mappings = {
		n = {
			['<leader>vr'] = {
				function() vim.lsp.buf.rename() end,
				{
					buffer = bufnr,
					desc = 'rename symbol'
				}
			},

			['<leader>va'] = {
				function() vim.lsp.buf.code_action() end,
				{
					buffer = bufnr,
					desc = 'LSP code actions'
				}
			},

			['<leader>vf'] = {
				function() vim.diagnostic.open_float() end,
				{
					buffer = bufnr,
					desc = 'LSP floating diagnostics'
				}
			},

			['<leader>vs'] = {
				function() vim.lsp.buf.signature_help() end,
				{
					buffer = bufnr,
					desc = 'LSP signature help'
				}
			},
    },

    v = {
      ['gw'] = {
        function()
          local p = function (tb) print(vim.inspect(tb)) end
          local fn = vim.fn
          local start = fn.getpos "'<"
          local finish = fn.getpos "'>"
          p(start); p(finish)
        end,
        {
          buffer = bufnr,
          desc = 'format selection'
        }
      }
		}
	}
	map(mappings)
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lsp.sumneko_lua.setup {
	capabilities = capabilities,
	on_attach = attach_fn,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most
				-- likely LuaJIT)
				version = 'LuaJIT',
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = { library = vim.api.nvim_get_runtime_file('', true) },
			-- Do not send telemetry data containing a randomized but unique
			-- identifier
			telemetry = { enable = false, },
		},
	},
}

lsp.tsserver.setup{
	capabilities = capabilities,
	on_attach = attach_fn
}

local ls = require'lspconfig'
local coq = require 'coq'

local rtp = vim.split(package.path, ';')
table.insert(rtp, 'lua/?.lua')
table.insert(rtp, 'lua/?/init.lua')

ls.sumneko_lua.setup(coq.lsp_ensure_capabilities {
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
				path = rtp
			},
			diagnostics = {
				globals = {'vim'}
			},
			workspace = {
				vim.api.nvim_get_runtime_file('', true)
			}
		}
	}
})

-- Deno typescript language server
-- ls.denols.setup(coq.lsp_ensure_capabilities())

-- Typescript language server
ls.tsserver.setup(coq.lsp_ensure_capabilities {
	on_attach = function(client)
		-- let null-ls do the formatting
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end
})

-- PHP language server
ls.phpactor.setup(coq.lsp_ensure_capabilities())

-- Dockerfile language server
ls.dockerls.setup(coq.lsp_ensure_capabilities())

-- Python language server
ls.pyright.setup(coq.lsp_ensure_capabilities())

-- yaml landguage server
ls.yamlls.setup(coq.lsp_ensure_capabilities())

-- json language server
ls.jsonls.setup(coq.lsp_ensure_capabilities {
	commands = {
		Format = {
			function()
				vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
			end
		}
	}
})

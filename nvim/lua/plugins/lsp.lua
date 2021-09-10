local ls = require'lspconfig'
local coq = require 'coq'

local sumneko_root_path = vim.fn.stdpath('data')..'/site/language-servers/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/macOS/lua-language-server"

local rtp = vim.split(package.path, ';')
table.insert(rtp, 'lua/?.lua')
table.insert(rtp, 'lua/?/init.lua')

ls.sumneko_lua.setup(coq.lsp_ensure_capabilities {
	cmd = { sumneko_binary, "-E", sumneko_root_path.."/main.lua" },
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
ls.denols.setup(coq.lsp_ensure_capabilities())

-- Dockerfile language server
ls.dockerls.setup(coq.lsp_ensure_capabilities())

-- Python language server
ls.pyright.setup(coq.lsp_ensure_capabilities())

-- yaml landguage server
ls.yamlls.setup(coq.lsp_ensure_capabilities())


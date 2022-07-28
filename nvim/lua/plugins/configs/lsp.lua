local present1, lsp = pcall(require, 'lspconfig')
local present2, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')

if not (present1 or present2) then
	print 'Plugins not found'
	return
end

print 'Setting up LSPs...'

local servers = {
	'sumneko_lua'
}

local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

local keymaps = function() end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lsp.sumneko_lua.setup {
	capabilities = capabilities,
	on_attach = keymaps,
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

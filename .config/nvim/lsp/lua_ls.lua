vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "Snacks" },
			},
			runtime = {
				version = "LuaJIT",
			},
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})

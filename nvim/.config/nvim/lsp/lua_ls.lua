vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			-- this is because of the lua 3.17.0 update
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					{ path = "snacks.nvim", words = { "Snacks" } }, -- others you need to load
				},
			},
			-- ends here
			runtime = { version = "LuaJIT" },
			completion = { callSnippet = "Replace" },
			telemetry = { enable = false },
		},
	},
})

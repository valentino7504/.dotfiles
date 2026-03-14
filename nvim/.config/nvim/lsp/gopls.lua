vim.lsp.config("gopls", {
	filetypes = { "go", "gomod" },
	settings = {
		gopls = {
			completeFunctionCalls = false,
		},
	},
})

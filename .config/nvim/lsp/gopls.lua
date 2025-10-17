vim.lsp.config("gopls", {
	filetypes = { "go", "go.mod", "go.work", "gotmpl" },
	settings = {
		gopls = {
			completeFunctionCalls = false,
		},
	},
})

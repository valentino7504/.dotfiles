vim.lsp.config("gopls", {
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	settings = {
		gopls = {
			completeFunctionCalls = false,
		},
	},
})

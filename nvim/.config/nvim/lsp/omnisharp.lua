local mason_root = vim.fn.stdpath("data") .. "/mason/packages/" --[[@as string]]
vim.lsp.config("omnisharp", {
	cmd = { "dotnet", mason_root .. "omnisharp/libexec/OmniSharp.dll" },
	settings = {
		FormattingOptions = {
			OrganizeImports = true,
		},
	},
})

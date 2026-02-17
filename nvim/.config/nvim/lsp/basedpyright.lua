vim.lsp.config("basedpyright", {
	settings = {
		basedpyright = {
			analysis = {
				-- uncomment the following line for loosey goosey code
				-- typeCheckingMode = "off",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
	},
})

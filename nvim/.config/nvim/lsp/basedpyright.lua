return {
	settings = {
		basedpyright = {
			analysis = {
				-- uncomment the following line for loosey goosey code
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
				inlayHints = {
					variableTypes = false,
					callArgumentNames = false,
				},
			},
		},
	},
}

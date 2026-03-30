return {
	settings = {
		ty = {
			inlayHints = {
				variableTypes = true,
				callArgumentNames = true,
			},
		},
	},
	on_attach = function()
		vim.lsp.inlay_hint.enable(true)
	end,
}

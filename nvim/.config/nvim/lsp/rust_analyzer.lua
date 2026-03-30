return {
	settings = {
		["rust-analyzer"] = {
			cachePriming = { enable = true },
			procMacro = { enable = true },
			check = { command = "clippy" },

			lens = { enable = false },
			inlayHints = {
				enable = true,
				showVariableReferences = false,
				parameterHints = { enable = true },
				typeHints = { enable = true },
				chainingHints = { enable = true },
			},
		},
	},
}

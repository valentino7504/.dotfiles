vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			cachePriming = { enable = true },
			procMacro = { enable = true },
			check = { command = "clippy" },

			lens = { enable = false },
			inlayHints = { enable = false },
		},
	},
})

return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach",
	priority = 1000,
	opts = {
		preset = "classic",
		options = {
			show_code = true,
			overflow = {
				mode = "wrap",
			},
		},
	},
}

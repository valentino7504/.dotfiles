return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach",
	priority = 1000,
	opts = {
		preset = "modern",
		options = {
			show_code = true,
			show_source = {
				enabled = true,
			},
			overflow = {
				mode = "wrap",
			},
		},
	},
}

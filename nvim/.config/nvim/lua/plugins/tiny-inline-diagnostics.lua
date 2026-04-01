return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach",
	priority = 1000,
	config = function()
		require("tiny-inline-diagnostic").setup({
			preset = "amongus",
			options = {
				show_code = true,
				overflow = {
					mode = "wrap",
				},
			},
		})
	end,
}

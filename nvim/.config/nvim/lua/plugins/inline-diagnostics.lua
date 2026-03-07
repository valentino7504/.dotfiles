return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy", -- Or `LspAttach`
	priority = 1000, -- needs to be loaded in first
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
		vim.diagnostic.config({ virtual_text = false })
	end,
}

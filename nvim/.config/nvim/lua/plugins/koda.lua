return {
	"oskarnurm/koda.nvim",
	lazy = true,
	config = function()
		require("koda").setup({
			transparent = true,
			auto = true,
			cache = true,
			styles = {
				functions = { bold = true, italic = false },
				keywords = { italic = true, bold = false },
				comments = { italic = true, bold = false },
				strings = {},
				constants = {},
			},
		})
	end,
}

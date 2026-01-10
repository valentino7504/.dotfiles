return {
	"oskarnurm/koda.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("koda").setup({
			transparent = true,
			styles = {
				functions = { bold = true, italic = false },
				keywords = { italic = true, bold = false },
				comments = { italic = true, bold = false },
				strings = {},
				constants = {},
			},
		})
		vim.cmd("colorscheme koda")
	end,
}

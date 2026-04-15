return {
	"oskarnurm/koda.nvim",
	cmd = "KodaFetch",
	-- priority = 1000,
	config = function()
		require("koda").setup({
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
		-- vim.cmd("colorscheme koda-moss")
	end,
}

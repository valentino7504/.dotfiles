return {
	"wtfox/jellybeans.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("jellybeans").setup({
			transparent = true,
		})
		vim.cmd.colorscheme("jellybeans")
	end,
}

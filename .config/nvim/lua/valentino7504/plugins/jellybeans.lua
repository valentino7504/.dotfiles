return {
	"wtfox/jellybeans.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("jellybeans").setup({
			italics = true,
		})
		vim.cmd.colorscheme("jellybeans-muted")
	end,
}

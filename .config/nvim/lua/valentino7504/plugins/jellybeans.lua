return {
	"wtfox/jellybeans.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("jellybeans").setup({
			transparent = false,
			-- palette = "jellybeans_muted",
		})
		-- vim.cmd.colorscheme("jellybeans")
	end,
}

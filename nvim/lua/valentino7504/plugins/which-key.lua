return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		preset = "helix",
	},
	mappings = {
		["<C-'>"] = { "<cmd>ToggleTerm<cr>", "Toggle Terminal" },
	},
}

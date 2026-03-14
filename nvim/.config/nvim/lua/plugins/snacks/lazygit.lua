return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		lazygit = { enabled = true },
	},
	keys = {
		{
			"<leader>lg",
			function()
				Snacks.lazygit.open()
			end,
			desc = "Lazygit",
		},
	},
}

return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		notify = {
			enabled = true,
		},
		notifier = {
			enabled = true,
			style = "compact",
			timeout = 6000,
		},
	},
	keys = {
		{
			"<leader>nl",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Show notification history",
		},
	},
}

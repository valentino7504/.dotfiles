return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		dashboard = {
			enabled = true,
			preset = {
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = "",
						key = "lg",
						desc = "LazyGit",
						action = ":lua Snacks.lazygit.open()",
					},
					{
						icon = " ",
						key = "s",
						desc = "Restore Session",
						action = require("core.utils").restore_session,
					},
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{
						icon = "󱊈",
						key = "M",
						desc = "Mason",
						action = ":Mason",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{
					pane = 1,
					section = "terminal",
					cmd = "fortune -s | cowsay && tail -f /dev/null",
					hl = "header",
					ttl = 0,
					height = 17,
				},
				{
					pane = 2,
					{ section = "keys", gap = 1 },
				},
			},
		},
	},
}

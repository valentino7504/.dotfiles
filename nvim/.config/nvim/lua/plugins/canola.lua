return {
	"barrettruth/canola.nvim",
	branch = "canola",
	dependencies = {
		{
			"barrettruth/canola-collection",
			init = function()
				vim.g.canola_git = {
					show = { untracked = true, ignored = true },
					format = "porcelain", -- 'compact' | 'symbol' | 'porcelain'
				}
			end,
		},
	},
	keys = {
		{
			"-",
			function()
				require("canola").toggle_float(vim.fn.getcwd())
			end,
			desc = "Open Canola in current working directory",
		},
		{
			"<leader>_",
			function()
				require("canola").toggle_float()
			end,
			desc = "Open Canola in parent directory of current buffer",
		},
	},
	init = function()
		vim.g.canola = {
			highlights = { columns = true },
			extglob = true,
			float = { border = "single" },
			keymaps = {
				["<BS>"] = { callback = "actions.parent" },
				["q"] = { callback = "actions.close" },
				["<Esc>"] = { callback = "actions.close" },
				["-"] = { callback = "actions.close" },
			},
			columns = { "git_status", "icon" },
		}
	end,
}

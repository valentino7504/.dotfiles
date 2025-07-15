return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = {
		{ "echasnovski/mini.icons", opts = {} },
		"refractalize/oil-git-status.nvim",
	},
	lazy = false,
	config = function()
		local oil = require("oil")
		local openCwd = function()
			oil.toggle_float(vim.fn.getcwd())
		end

		oil.setup({
			keymaps = {
				["<BS>"] = { "actions.parent", mode = "n" },
				["q"] = { "actions.close", mode = "n" },
				["-"] = false,
				["_"] = false,
			},
			win_options = {
				signcolumn = "yes:2",
			},
			show_hidden = false,
		})
		vim.keymap.set("n", "<leader>_", oil.toggle_float, { desc = "Open Oil in parent directory of current buffer" })
		vim.keymap.set("n", "-", openCwd, { desc = "Open Oil in current working directory" })
		require("oil-git-status").setup()
	end,
}

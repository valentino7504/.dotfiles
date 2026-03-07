return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = {
		{ "echasnovski/mini.icons", opts = {} },
		{
			"malewicz1337/oil-git.nvim",
			dependencies = { "stevearc/oil.nvim" },
			opts = {
				show_file_highlights = true,
				show_directory_highlights = false,
				show_ignored_files = true,
			},
		},
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
				["<Esc>"] = { "actions.close", mode = "n" },
				["-"] = false,
				["_"] = false,
			},
			win_options = {
				signcolumn = "yes:2",
			},
			view_options = {
				show_hidden = true,
			},
		})
		vim.keymap.set("n", "<leader>_", oil.toggle_float, { desc = "Open Oil in parent directory of current buffer" })
		vim.keymap.set("n", "-", openCwd, { desc = "Open Oil in current working directory" })
	end,
}

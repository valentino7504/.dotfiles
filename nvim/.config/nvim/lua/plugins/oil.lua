return {
	"stevearc/oil.nvim",
	cmd = "Oil",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = {
		{ "echasnovski/mini.icons", opts = {} },
		{
			"malewicz1337/oil-git.nvim",
			dependencies = { "stevearc/oil.nvim" },
			cmd = "Oil",
			opts = {
				show_file_highlights = true,
				show_directory_highlights = false,
				show_ignored_files = true,
			},
		},
	},
	init = function()
		vim.keymap.set("n", "<leader>_", function()
			require("oil").toggle_float()
		end, { desc = "Open Oil in parent directory of current buffer" })
		vim.keymap.set("n", "-", function()
			require("oil").toggle_float(vim.fn.getcwd())
		end, { desc = "Open Oil in current working directory" })
	end,
	config = function()
		local oil = require("oil")
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
	end,
}

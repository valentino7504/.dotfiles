return {
	"stevearc/oil.nvim",
	cmd = "Oil",
	---@module 'oil'
	---@type oil.SetupOpts
	keys = {
		{
			"-",
			function()
				require("oil").toggle_float(vim.fn.getcwd())
			end,
			desc = "Open Oil in current working directory",
		},
		{
			"<leader>_",
			function()
				require("oil").toggle_float()
			end,
			desc = "Open Oil in parent directory of current buffer",
		},
	},
	dependencies = {
		{ "echasnovski/mini.icons", opts = {} },
		{
			"malewicz1337/oil-git.nvim",
			opts = {
				show_file_highlights = true,
				show_directory_highlights = false,
				show_ignored_files = true,
			},
		},
	},
	init = function(p)
		if vim.fn.argc() == 1 then
			local argv = tostring(vim.fn.argv(0))
			local stat = vim.loop.fs_stat(argv)

			local remote_dir_args = vim.startswith(argv, "ssh")
				or vim.startswith(argv, "sftp")
				or vim.startswith(argv, "scp")

			if stat and stat.type == "directory" or remote_dir_args then
				require("lazy").load({ plugins = { p.name } })
			end
		end
		if not require("lazy.core.config").plugins[p.name]._.loaded then
			vim.api.nvim_create_autocmd("BufNew", {
				callback = function()
					if vim.fn.isdirectory(vim.fn.expand("<afile>")) == 1 then
						require("lazy").load({ plugins = { "oil.nvim" } })
						-- Once oil is loaded, we can delete this autocmd
						return true
					end
				end,
			})
		end
	end,
	opts = {
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
	},
}

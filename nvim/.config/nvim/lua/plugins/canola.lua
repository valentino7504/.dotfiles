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
	cmd = "Canola",
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
						require("lazy").load({ plugins = { "canola.nvim" } })
						-- Once canola is loaded, we can delete this autocmd
						return true
					end
				end,
			})
		end
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

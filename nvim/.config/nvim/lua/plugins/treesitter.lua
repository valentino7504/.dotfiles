return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")

			local parsers = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"markdown",
				"markdown_inline",
				"bash",
				"lua",
				"vim",
				"gitignore",
				"c",
				"go",
				"python",
				"c_sharp",
				"sql",
				"gosum",
				"gomod",
				"dockerfile",
				"rust",
			}

			ts.install(parsers)

			-- vim.api.nvim_create_autocmd("FileType", {
			-- 	group = vim.api.nvim_create_augroup("treesitter_features", { clear = true }),
			-- 	callback = function(ev)
			-- 		local lang = ev.match
			-- 		pcall(vim.treesitter.start, ev.buf, lang)
			-- 		vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			-- 	end,
			-- })
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "xml" },
	},
}

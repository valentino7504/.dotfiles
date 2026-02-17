require("valentino7504.core.options")
require("valentino7504.core.keymaps")

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(args)
		local bufname = vim.api.nvim_buf_get_name(args.buf)
		if string.find(bufname, "/.local/share/nvim/leetcode/") then
			vim.api.nvim_clear_autocmds({ buffer = args.buf })
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.{js,c,ts,go,jsx,css,py}",
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual" })
	end,
})
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.cmd("setlocal nonumber norelativenumber")
	end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.tmpl",
	command = "set filetype=gotmpl",
})

vim.diagnostic.config({
	float = { border = "single" },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
		},
	},
})

vim.filetype.add({
	filename = {
		[".zshrc"] = "zsh",
		[".zprofile"] = "zsh",
	},
})

require("valentino7504.core.options")
require("valentino7504.core.keymaps")

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
	command = "set filetype=html",
})

if vim.fn.executable("zsh") == 1 then
	vim.opt.shell = "zsh"
elseif vim.fn.executable("bash") == 1 then
	vim.opt.shell = "bash"
end

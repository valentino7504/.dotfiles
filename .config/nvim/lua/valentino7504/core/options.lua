vim.cmd("let g:netrw_liststyle=3")
local opt = vim.opt
opt.clipboard:append("unnamedplus")
opt.relativenumber = true
opt.number = true
opt.statuscolumn = "%s%3l|%{v:relnum}  %C"
opt.autoindent = false
opt.smartindent = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
vim.opt.mouse = ""
vim.hl = vim.highlight
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
		vim.highlight.on_yank({ higroup = "Visual", timeout = 225 })
	end,
})

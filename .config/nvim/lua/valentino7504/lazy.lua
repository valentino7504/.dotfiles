local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "valentino7504.plugins" },
	{ import = "valentino7504.plugins.lsp" },
	{ import = "valentino7504.plugins.mini" },
	{ import = "valentino7504.plugins.snacks" },
}, {
	checker = {
		enabled = true,
		notify = false,
	},
	ui = {
		backdrop = 100,
	},
	change_detection = {
		notify = false,
	},
})

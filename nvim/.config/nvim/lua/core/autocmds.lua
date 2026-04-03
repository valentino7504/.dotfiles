local augroup = vim.api.nvim_create_augroup("user_autocmds", { clear = true })

-- Clear autocmds in leetcode buffers
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup,
	callback = function(args)
		local bufname = vim.api.nvim_buf_get_name(args.buf)
		if string.find(bufname, "/.local/share/nvim/leetcode/") then
			vim.api.nvim_clear_autocmds({ buffer = args.buf })
		end
	end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank({ timeout = 200 })
	end,
})

-- Use treesitter for syntax highlighting
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

-- Use q to close undotree
vim.api.nvim_create_autocmd("FileType", {
	pattern = "nvim-undotree",
	callback = function(ev)
		vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = ev.buf, silent = true })
	end,
})

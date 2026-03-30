local augroup = vim.api.nvim_create_augroup("user_autocmds", { clear = true })

-- Remove autocmds when in leetcode buffers
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

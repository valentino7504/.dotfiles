-- Remove autocmds when in leetcode buffers
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(args)
		local bufname = vim.api.nvim_buf_get_name(args.buf)
		if string.find(bufname, "/.local/share/nvim/leetcode/") then
			vim.api.nvim_clear_autocmds({ buffer = args.buf })
		end
	end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank({ timeout = 200 })
	end,
})

-- Auto-restore session if one exists in cwd (only when opening nvim with no args)
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 0 then
			local session = vim.fn.getcwd() .. "/.session.vim"
			if vim.fn.filereadable(session) == 1 then
				vim.cmd("source " .. session)
			end
		end
	end,
})

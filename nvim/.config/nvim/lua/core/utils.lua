local M = {}

M.toggle_terminal = function()
	local term_buf = nil
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" then
			term_buf = buf
			break
		end
	end

	if not term_buf then
		-- No terminal buffer: open new terminal split and start insert mode
		vim.cmd("botright 14split | term")
		vim.cmd("startinsert")
		return
	end

	-- Find window showing the terminal buffer
	local term_win = nil
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_buf(win) == term_buf then
			term_win = win
			break
		end
	end

	if term_win then
		if vim.api.nvim_get_current_win() == term_win then
			-- If already in terminal window, exit insert mode and go back to previous window
			vim.cmd("stopinsert")
			vim.cmd("wincmd p")
		else
			-- Otherwise, switch to terminal window and enter insert mode
			vim.api.nvim_set_current_win(term_win)
			vim.cmd("startinsert")
		end
	else
		-- Terminal buffer exists but no window showing it: open split and show buffer
		vim.cmd("botright 14split")
		vim.api.nvim_win_set_buf(0, term_buf)
		vim.cmd("startinsert")
	end
end

return M

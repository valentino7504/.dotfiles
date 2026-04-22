local M = {}

local session_path = vim.fn.getcwd() .. "/.session.vim"

M.restore_session = function()
	if vim.fn.filereadable(session_path) == 1 then
		vim.cmd("source " .. session_path)
		vim.notify("Session restored from " .. session_path, vim.log.levels.INFO)
	else
		vim.notify("No session available to load")
	end
end

M.save_session = function()
	vim.cmd("mksession! " .. session_path)
	vim.notify("Session saved to " .. session_path, vim.log.levels.INFO)
end

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

M.notification_history = function()
	local output = vim.fn.execute("messages")
	local raw = vim.split(output, "\n", { trimempty = true })

	if #raw == 0 then
		vim.notify("No messages from this session.", vim.log.levels.INFO)
		return
	end

	local lines = {}
	for i, line in ipairs(raw) do
		lines[i] = string.format("%d. %s", i, line)
	end

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })

	local width = math.floor(vim.o.columns * 0.6)
	local height = math.min(#lines, math.floor(vim.o.lines * 0.4))
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		border = "rounded",
		title = " Messages ",
		title_pos = "center",
		style = "minimal",
	})

	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win, true)
	end, { buffer = buf, silent = true })
end

return M

-- Experimental UI2: floating cmdline and messages
local ui2 = require("vim._core.ui2")
ui2.enable({
	enable = true,
	msg = {
		targets = {
			[""] = "msg",
			empty = "cmd",
			bufwrite = "msg",
			confirm = "cmd",
			emsg = "pager",
			echo = "msg",
			echomsg = "msg",
			echoerr = "pager",
			completion = "cmd",
			list_cmd = "pager",
			lua_error = "pager",
			lua_print = "msg",
			progress = "pager",
			rpc_error = "pager",
			quickfix = "msg",
			search_cmd = "cmd",
			search_count = "cmd",
			shell_cmd = "pager",
			shell_err = "pager",
			shell_out = "pager",
			shell_ret = "msg",
			undo = "msg",
			verbose = "pager",
			wildlist = "cmd",
			wmsg = "msg",
			typed_cmd = "cmd",
		},
		cmd = {
			height = 0.5,
		},
		dialog = {
			height = 0.5,
		},
		msg = {
			height = 0.3,
			timeout = 5000,
		},
		pager = {
			height = 0.5,
		},
	},
})

local msgs = require("vim._core.ui2.messages")
local orig_set_pos = msgs.set_pos
msgs.set_pos = function(tgt)
	orig_set_pos(tgt)
	if (tgt == "msg" or tgt == nil) and vim.api.nvim_win_is_valid(ui2.wins.msg) then
		pcall(vim.api.nvim_win_set_config, ui2.wins.msg, {
			relative = "editor",
			anchor = "NE",
			row = 1,
			col = vim.o.columns - 1,
			border = "rounded",
		})
	end
end

local function tabline()
	local s = ""
	for i = 1, vim.fn.tabpagenr("$") do
		local winnr = vim.fn.tabpagewinnr(i)
		local bufnr = vim.fn.tabpagebuflist(i)[winnr]
		local bufname = vim.fn.bufname(bufnr)
		local filename = bufname ~= "" and vim.fn.fnamemodify(bufname, ":t") or "[No Name]"
		local modified = vim.bo[bufnr].modified

		if i == vim.fn.tabpagenr() then
			s = s .. "%#TabLineSel#"
		else
			s = s .. "%#TabLine#"
		end

		s = s .. " %" .. i .. "T"
		if i > 1 then
			s = s .. "▎ "
		end
		s = s .. filename

		if modified then
			s = s .. " %#TabLineModified#●"
			if i == vim.fn.tabpagenr() then
				s = s .. "%#TabLineSel#"
			else
				s = s .. "%#TabLine#"
			end
		end

		s = s .. " "
	end

	s = s .. "%#TabLineFill#%T"
	return s
end

_G.MyTabline = tabline
vim.o.tabline = "%!v:lua.MyTabline()"

vim.api.nvim_set_hl(0, "TabLineModified", { link = "DiagnosticWarn" })
vim.api.nvim_set_hl(0, "TabLineFill", { link = "StatusLine" })

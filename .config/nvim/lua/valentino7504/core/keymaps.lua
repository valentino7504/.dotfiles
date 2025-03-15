vim.g.mapleader = " "
local keymap = vim.keymap
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>=", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- split window keymaps
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
keymap.set("", "<up>", "<nop>", { noremap = true })
keymap.set("", "<down>", "<nop>", { noremap = true })
keymap.set("i", "<up>", "<nop>", { noremap = true })
keymap.set("i", "<down>", "<nop>", { noremap = true })

local function toggle_terminal()
	local term_buf = nil
	-- Iterate through buffers to find a terminal buffer
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" then
			term_buf = buf
			break
		end
	end
	if not term_buf then
		-- If no terminal is open, create one with the specified configuration
		vim.cmd("botright 14split | term")
		vim.cmd("setlocal norelativenumber nonumber")
		vim.cmd("startinsert")
	else
		local term_win = nil
		-- Check if the terminal buffer is visible in any window
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_get_buf(win) == term_buf then
				term_win = win
				break
			end
		end
		if term_win then
			if vim.api.nvim_get_current_win() == term_win then
				-- If in terminal mode, switch to normal mode and back to the previous window
				vim.cmd("stopinsert")
				vim.cmd("wincmd p")
			else
				-- Switch to the terminal window
				vim.api.nvim_set_current_win(term_win)
				vim.cmd("startinsert")
			end
		else
			-- Terminal buffer exists but is not visible, open it
			vim.cmd("botright 14split")
			vim.api.nvim_win_set_buf(0, term_buf)
			vim.cmd("startinsert")
		end
	end
end
keymap.set({ "n", "i" }, "<C-t>", toggle_terminal, { noremap = true, silent = true, desc = "Toggle Terminal" })
keymap.set(
	"t",
	"<Esc>",
	"<C-\\><C-n>",
	{ noremap = true, silent = true, desc = "Switch to normal mode when in terminal mode" }
)
keymap.set("t", "<C-t>", "<C-\\><C-n><cmd>q<CR>", { noremap = true, silent = true, desc = "Close Terminal" })

local function lazy(keys)
	keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
	return function()
		local old = vim.o.lazyredraw
		vim.o.lazyredraw = true
		vim.api.nvim_feedkeys(keys, "nx", false)
		vim.o.lazyredraw = old
	end
end

keymap.set("n", "<c-d>", lazy("<c-d>zz"), { desc = "Scroll down half screen" })
keymap.set("n", "<leader>Gd", "<cmd>GoDoc<CR>", { noremap = true, silent = true, desc = "Open Go docs" })
keymap.set("n", "<leader>Gp", "<cmd>PyDoc<CR>", { noremap = true, silent = true, desc = "Open Python docs" })

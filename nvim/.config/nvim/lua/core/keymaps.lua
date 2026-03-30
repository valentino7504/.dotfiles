local utils = require("core.utils")
vim.g.mapleader = " "
local keymap = vim.keymap
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

keymap.set("n", "<leader>=", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
keymap.set("", "<up>", "<nop>", { noremap = true })
keymap.set("", "<down>", "<nop>", { noremap = true })
keymap.set("i", "<up>", "<nop>", { noremap = true })
keymap.set("i", "<down>", "<nop>", { noremap = true })

keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute current lua line in vim" })
keymap.set("n", "<leader>x", ":.lua<CR>")
keymap.set("v", "<leader>x", ":lua<CR>")

keymap.set("n", "<leader>ss", utils.save_session, { desc = "Save session" })
keymap.set("n", "<leader>sr", utils.restore_session, { desc = "Restore session" })

keymap.set("ia", ";-m", "—")
keymap.set("ia", ";-n", "–")
keymap.set({ "n", "i" }, "<C-t>", utils.toggle_terminal, { noremap = true, silent = true, desc = "Toggle Terminal" })
keymap.set("t", "<C-t>", "<C-\\><C-n><cmd>q<CR>", { noremap = true, silent = true, desc = "Close Terminal" })
keymap.set(
	"t",
	"<Esc>",
	"<C-\\><C-n>",
	{ noremap = true, silent = true, desc = "Switch to normal mode when in terminal mode" }
)
keymap.set("n", "<c-d>", "<c-d>zz", { desc = "Scroll down half screen" })

local utils = require("core.utils")
local keymap = vim.keymap

-- Leader key
vim.g.mapleader = " "

-- General
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>=", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })
keymap.set("n", "<c-d>", "<c-d>zz", { desc = "Scroll down half screen" })

-- Splits
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Terminal
keymap.set({ "n", "i" }, "<C-t>", utils.toggle_terminal, { noremap = true, silent = true, desc = "Toggle terminal" })
keymap.set("t", "<C-t>", "<C-\\><C-n><cmd>q<CR>", { noremap = true, silent = true, desc = "Close terminal" })
keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal mode" })

-- Session
keymap.set("n", "<leader>ss", utils.save_session, { desc = "Save session" })
keymap.set("n", "<leader>sr", utils.restore_session, { desc = "Restore session" })

-- Lua execution
keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Source current file" })
keymap.set("n", "<leader>x", ":.lua<CR>", { desc = "Execute current line as Lua" })
keymap.set("v", "<leader>x", ":lua<CR>", { desc = "Execute selection as Lua" })

-- Insert mode abbreviations
keymap.set("ia", ";-m", "—", { desc = "Em dash" })
keymap.set("ia", ";-n", "–", { desc = "En dash" })

-- Disable arrow keys (enforce hjkl)
keymap.set("", "<up>", "<nop>", { noremap = true })
keymap.set("", "<down>", "<nop>", { noremap = true })
keymap.set("i", "<up>", "<nop>", { noremap = true })
keymap.set("i", "<down>", "<nop>", { noremap = true })

-- Neovim
keymap.set("n", "<leader>rs", "<cmd>restart<CR>", { desc = "Restart Neovim" })

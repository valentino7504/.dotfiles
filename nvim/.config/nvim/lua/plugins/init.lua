vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nohlsearch")
vim.keymap.set("n", "<leader>u", function()
	require("undotree").open({ command = "40vnew" })
end, { desc = "Open Undotree" })

return {}

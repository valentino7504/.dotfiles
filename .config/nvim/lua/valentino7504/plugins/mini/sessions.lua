return {
	"nvim-mini/mini.sessions",
	version = false,
	config = function()
		require("mini.sessions").setup({
			file = ".session.vim",
			autoread = true,
			autowrite = false,
		})
		local keymap = vim.keymap
		keymap.set("n", "<leader>ss", ":lua MiniSessions.write('.session.vim')<CR>", { desc = "Save session" })
	end,
}

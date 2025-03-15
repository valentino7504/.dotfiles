return {
	"vidocqh/data-viewer.nvim",
	ft = "csv",
	opts = {},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>dv", "<Cmd>DataViewer<CR>", { silent = true, desc = "Open DataViewer" })
	end,
}

return {
	"echasnovski/mini.notify",
	version = false,
	config = function()
		local MiniNotify = require("mini.notify")
		MiniNotify.setup({
			lsp_progress = {
				enable = false,
			},
		})
		vim.notify = MiniNotify.make_notify()
	end,
}

return {
	{
		"milanglacier/minuet-ai.nvim",
		config = function()
			require("minuet").setup({
				-- Your configuration options here
				provider = "gemini",
				provider_options = {
					gemini = {
						model = "gemini-2.5-flash-lite",
						optional = {
							generationConfig = {
								maxOutputTokens = 256,
								thinkingConfig = {
									thinkingBudget = 0,
								},
							},
						},
					},
				},
				context_window = 4000,
				context_ratio = 0.75,
				throttle = 2000,
				debounce = 800,
				virtualtext = {
					auto_trigger_ft = {},
					keymap = {
						accept = "<Tab>",
					},
				},
				request_timeout = 2.5,
			})
			vim.keymap.set("n", "<leader>mt", ":Minuet virtualtext toggle<CR>", { desc = "Toggle AI completion" })
		end,
	},
	{ "nvim-lua/plenary.nvim" },
}

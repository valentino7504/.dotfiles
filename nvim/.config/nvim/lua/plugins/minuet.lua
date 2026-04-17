return {
	"milanglacier/minuet-ai.nvim",
	keys = {
		{ "<leader>mt", ":Minuet virtualtext toggle<CR>", desc = "Toggle AI completion" },
	},
	config = function()
		local ok, secrets = pcall(require, "secrets")
		local key = secrets and secrets.GEMINI_API_KEY

		if ok and type(secrets) == "table" then
			local k = secrets.GEMINI_API_KEY
			if type(k) == "string" and k ~= "" then
				key = k
			end
		end

		if not key then
			key = vim.env.GEMINI_API_KEY
		end

		if type(key) ~= "string" or key == "" then
			vim.notify("Minuet disabled: GEMINI_API_KEY not set", vim.log.levels.ERROR)
			return
		end

		vim.env.GEMINI_API_KEY = key

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
					accept = "<C-y>",
				},
			},
			request_timeout = 2.5,
		})
	end,
}

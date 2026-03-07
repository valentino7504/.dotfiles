return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		picker = {
			enabled = true,
		},
	},
	keys = {
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep Find",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Find Git Files",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Find Recent Files",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Find Open Buffer",
		},
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"<leader>gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"gy",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto T[y]pe Definition",
		},
		{
			"<leader>sS",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>uC",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Colorschemes",
		},
		{
			"<leader>D",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Show diagnostics",
		},
	},
}

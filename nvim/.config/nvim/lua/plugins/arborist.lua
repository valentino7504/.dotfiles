return {
	"arborist-ts/arborist.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("arborist").setup({
			update_cadence = "weekly",
			prefer_wasm = false,
			ignore = {
				"canola",
				"snacks_dashboard",
			},
		})
	end,
}

return {
	"arborist-ts/arborist.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("arborist").setup({
			update_cadence = "weekly",
			ignore = {
				"canola",
				"snacks_dashboard",
			},
		})
	end,
}

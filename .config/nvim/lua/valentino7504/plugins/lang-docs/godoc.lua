return {
	"fredrikaverpil/godoc.nvim",
	version = "*",
	dependencies = {
		{ "folke/snacks.nvim" },
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = { "go" },
			},
		},
	},
	cmd = { "GoDoc" },
	opts = {
		picker = {
			type = "snacks",
		},
	},
}

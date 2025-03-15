return {
	"fredrikaverpil/pydoc.nvim",
	dependencies = {
		{ "folke/snacks.nvim" },
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = { "markdown" },
			},
		},
	},
	cmd = { "PyDoc" },
	opts = {
		picker = {
			type = "snacks",
		},
	},
}

return {
	"nvim-mini/mini.comment",
	event = "BufReadPost",
	version = false,
	config = function()
		require("mini.comment").setup()
	end,
}

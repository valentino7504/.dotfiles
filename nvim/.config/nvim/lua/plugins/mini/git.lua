return {
	"nvim-mini/mini-git",
	event = "BufReadPre",
	version = false,
	config = function()
		require("mini.git").setup()
	end,
}

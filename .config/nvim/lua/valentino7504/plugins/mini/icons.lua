return {
	"nvim-mini/mini.icons",
	version = false,
	opts = {},
	lazy = true,
	init = function()
		require("mini.icons").mock_nvim_web_devicons()
	end,
}

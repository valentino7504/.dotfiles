return {
	-- "nvim-lualine/lualine.nvim",
	-- dependencies = { "echasnovski/mini.icons" },
	-- config = function()
	-- 	local lualine = require("lualine")
	--
	-- 	lualine.setup({
	-- 		options = {
	-- 			theme = "auto",
	-- 			component_separators = { left = "|", right = "|" },
	-- 			section_separators = { left = "", right = "" },
	-- 		},
	-- 		sections = {
	-- 			lualine_c = {
	-- 				{ "filename" },
	-- 				{
	-- 					"harpoon2",
	-- 					icon = "♥",
	-- 					indicators = { "1", "2", "3", "4" },
	-- 					active_indicators = { "[1]", "[2]", "[3]", "[4]" },
	-- 					color_active = { fg = "#00ff00" },
	-- 					_separator = " ",
	-- 					no_harpoon = "Harpoon not loaded",
	-- 				},
	-- 			},
	-- 			lualine_x = {
	-- 				{ "encoding" },
	-- 				{ "fileformat" },
	-- 				{ "filetype" },
	-- 			},
	-- 		},
	-- 	})
	-- end,
	"echasnovski/mini.statusline",
	version = false,
	config = function()
		require("mini.statusline").setup()
	end,
}

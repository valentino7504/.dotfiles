return {
	"slugbyte/lackluster.nvim",
	lazy = false,
	priority = 1000,
	init = function()
		local lackluster = require("lackluster")
		local light_bg = "#191919"
		local lighter_bg = "#2A2A2A"
		local lack = "#708090"
		lackluster.setup({
			tweak_highlight = {
				["@keyword"] = {
					overwrite = false,
					italic = true,
				},
				["@type"] = {
					overwrite = false,
					italic = true,
				},
				["@comment"] = {
					overwrite = false,
					italic = true,
				},
				["@keyword.return"] = {
					overwrite = false,
					italic = true,
				},
				["LineNr"] = {
					overwrite = false,
					fg = lighter_bg,
				},
				["CursorLineNr"] = {
					overwrite = false,
					fg = "#DEEEED",
				},
				["CursorLine"] = {
					overwrite = false,
					bg = "NONE",
				},
				["SnacksPickerBorder"] = {
					overwrite = false,
					fg = light_bg,
					bg = light_bg,
				},
				["SnacksPickerPreviewTitle"] = {
					overwrite = false,
					fg = lack,
					bg = lighter_bg,
				},
				["SnacksPickerTitle"] = {
					overwrite = false,
					fg = lack,
					bg = lighter_bg,
				},
			},
			tweak_background = {
				normal = "none",
			},
		})
		vim.cmd.colorscheme("lackluster-hack")
	end,
}

return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	config = function()
		local palette = {
			ice_fog = "#c5c9c5", -- foreground
			void_stone = "#0f0d0c", -- background
			cloud_steel = "#8ba4b0", -- desaturated light blue
			dusk_amber = "#c8c093", -- warm faded amber
			ash_nest = "#1f1f1f", -- muted coal for cursorline
		}

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = function()
				local highlight_groups = {
					SnacksPickerBorder = { fg = palette.void_stone, bg = palette.void_stone },
					SnacksPickerInput = { fg = palette.ice_fog, bg = palette.ash_nest },
					SnacksPickerInputBorder = { fg = palette.ice_fog, bg = palette.ash_nest },
					SnacksPickerBoxBorder = { fg = palette.ash_nest, bg = palette.ash_nest },
					SnacksPickerTitle = { fg = palette.void_stone, bg = palette.cloud_steel },
					SnacksPickerBoxTitle = { fg = palette.ash_nest, bg = palette.cloud_steel },
					SnacksPickerList = { bg = palette.ash_nest, fg = palette.ice_fog },
					SnacksPickerPrompt = { fg = palette.ice_fog, bg = palette.ash_nest },
					SnacksPickerPreviewTitle = { fg = palette.void_stone, bg = palette.dusk_amber },
					SnacksPickerPreview = { bg = palette.void_stone },
					SnacksPickerToggle = { bg = palette.cloud_steel, fg = palette.void_stone },
				}

				for group, pal in pairs(highlight_groups) do
					vim.api.nvim_set_hl(0, group, pal)
				end
			end,
		})
		require("kanagawa").setup({
			typeStyle = { italic = true },
			transparent = true,
			colors = {
				palette = {
					dragonBlack0 = palette.void_stone,
					dragonBlack1 = palette.void_stone,
					dragonBlack2 = palette.void_stone,
					dragonBlack3 = palette.void_stone,
					dragonBlack4 = palette.void_stone,
					dragonBlack5 = palette.ash_nest,
					sumiInk3 = palette.void_stone,
				},
			},
		})
		vim.cmd.colorscheme("kanagawa-dragon")
	end,
}

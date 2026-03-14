return {
	"nvim-mini/mini.statusline",
	version = false,
	config = function()
		require("mini.statusline").setup({
			content = {
				active = function()
					-- Existing mini.statusline sections
					local mode, location, git, diag, fileinfo, filename, lsp =
						MiniStatusline.section_mode({}),
						MiniStatusline.section_location({}),
						MiniStatusline.section_git({}),
						MiniStatusline.section_diagnostics({}),
						MiniStatusline.section_fileinfo({}),
						MiniStatusline.section_filename({}),
						MiniStatusline.section_lsp({})

					-- time section: HH:MM
					local time = os.date("%I:%M%p")

					return MiniStatusline.combine_groups({
						{ hl = "MiniStatuslineModeNormal", strings = { mode } },
						{ hl = "MiniStatuslineDevinfo", strings = { lsp, git, diag } },
						"%<", -- Truncation point
						{ hl = "MiniStatuslineFilename", strings = { filename } },
						"%=", -- Right align
						{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
						{ hl = "MiniStatuslineModeOther", strings = { location } },
						{ hl = "MiniStatuslineModeNormal", strings = { time } }, -- Time added here
					})
				end,
			},
		})
	end,
}

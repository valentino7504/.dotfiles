return {
	"nvim-mini/mini.statusline",
	version = false,
	config = function()
		local wakatime_cli = vim.fn.expand("~/.wakatime/wakatime-cli")
		local wakatime_time = ""

		local function fetch_wakatime()
			if vim.fn.executable(wakatime_cli) ~= 1 then
				return
			end
			vim.system({ wakatime_cli, "--today" }, { text = true }, function(result)
				if result.code == 0 and result.stdout then
					local trimmed = result.stdout:gsub("%s+$", ""):gsub(" hrs?", "h"):gsub(" mins?", "m")
					vim.schedule(function()
						wakatime_time = trimmed ~= "" and ("⏱ " .. trimmed) or ""
					end)
				end
			end)
		end

		fetch_wakatime()

		local timer = vim.uv.new_timer()
		if not timer then
			vim.notify("WakaTime: failed to create timer", vim.log.levels.WARN)
			return
		end
		timer:start(5 * 60 * 1000, 5 * 60 * 1000, fetch_wakatime)

		require("mini.statusline").setup({
			content = {
				active = function()
					local mode, location, git, diag, fileinfo, filename, lsp =
						MiniStatusline.section_mode({}),
						MiniStatusline.section_location({}),
						MiniStatusline.section_git({}),
						MiniStatusline.section_diagnostics({}),
						MiniStatusline.section_fileinfo({}),
						MiniStatusline.section_filename({}),
						MiniStatusline.section_lsp({})

					local time = os.date("%I:%M%p")

					return MiniStatusline.combine_groups({
						{ hl = "MiniStatuslineModeNormal", strings = { mode } },
						{ hl = "MiniStatuslineDevinfo", strings = { lsp, git, diag } },
						"%<",
						{ hl = "MiniStatuslineFilename", strings = { filename } },
						"%=",
						{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
						{ hl = "MiniStatuslineModeOther", strings = { location } },
						{ hl = "MiniStatuslineModeNormal", strings = { wakatime_time } },
						{ hl = "MiniStatuslineModeNormal", strings = { " " .. time } },
					})
				end,
			},
		})
	end,
}

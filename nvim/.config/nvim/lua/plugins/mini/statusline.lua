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
			config = {
				use_icons = true,
			},
			content = {
				active = function()
					local mode, mode_hl = MiniStatusline.section_mode({})
					local location, git, diag, fileinfo, filename, lsp, search_count =
						MiniStatusline.section_location({}),
						MiniStatusline.section_git({}),
						MiniStatusline.section_diagnostics({}),
						MiniStatusline.section_fileinfo({ trunc_width = 9999999999999 }),
						MiniStatusline.section_filename({ trunc_width = 9999999999999 }),
						MiniStatusline.section_lsp({}),
						MiniStatusline.section_searchcount({})

					return MiniStatusline.combine_groups({
						{ hl = mode_hl, strings = { mode } },
						{ hl = "MiniStatuslineDevinfo", strings = { git, lsp, diag } },
						"%<",
						{ hl = "MiniStatuslineFilename", strings = { filename } },
						"%=",
						{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
						{ hl = "MiniStatuslineInactive", strings = { location } },
						{ hl = "MiniStatuslineModeNormal", strings = { wakatime_time } },
					})
				end,
			},
		})
	end,
}

return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",
	build = "...",
	version = "1.*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "enter",
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
		completion = {
			list = {
				selection = {
					preselect = false,
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 0,
			},
		},
		signature = {
			enabled = true,
		},
	},
	opts_extend = { "sources.default" },
}

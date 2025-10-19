return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"nvim-mini/mini.icons",
	},
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
			menu = {
				draw = {
					columns = {
						{ "kind_icon" },
						{ "label", gap = 1 },
						{ "kind" },
					},
					components = {
						kind_icon = {
							text = function(ctx)
								local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
								return kind_icon
							end,
							-- (optional) use highlights from mini.icons
							highlight = function(ctx)
								local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
								return hl
							end,
						},
						kind = {
							-- (optional) use highlights from mini.icons
							highlight = function(ctx)
								local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
								return hl
							end,
						},
					},
				},
			},
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
			window = {
				show_documentation = true,
			},
		},
	},
	opts_extend = { "sources.default" },
}

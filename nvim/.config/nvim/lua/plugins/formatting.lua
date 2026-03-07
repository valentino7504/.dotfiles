return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				javascript = { "biome" },
				typescript = { "biome" },
				javascriptreact = { "biome" },
				typescriptreact = { "biome" },
				css = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				html = { "prettier" },
				markdown = { "prettier" },
				lua = { "stylua" },
				python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
				go = { "gofumpt" },
				zsh = { "beautysh" },
				-- java = { "google-java-format" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = true,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}

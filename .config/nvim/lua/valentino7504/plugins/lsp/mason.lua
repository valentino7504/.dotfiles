return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"html",
				"cssls",
				"omnisharp",
				"emmet_ls",
				"lua_ls",
				"basedpyright",
				"gopls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"stylua", -- lua formatter
				"golangci-lint",
				"prettier",
				"eslint_d",
				"black",
				"isort",
				"ruff",
				"checkmake",
				"gofumpt",
				"goimports",
			},
		})
	end,
}

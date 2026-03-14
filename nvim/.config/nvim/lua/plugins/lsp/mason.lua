return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			local mason = require("mason")
			local mason_tool_installer = require("mason-tool-installer")

			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			mason_tool_installer.setup({
				ensure_installed = {
					"stylua",
					"golangci-lint",
					"prettier",
					-- "eslint_d",
					"biome",
					"ruff",
					"beautysh",
					"checkmake",
					"gofumpt",
					"goimports",
					"hadolint",
				},
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({
				ensure_installed = {
					"html",
					"cssls",
					"omnisharp",
					"emmet_ls",
					"lua_ls",
					"gopls",
					-- "jdtls",
					"ty",
					"docker_compose_language_service",
					"dockerls",
					"ts_ls",
					"rust_analyzer",
				},
			})
		end,
	},
}

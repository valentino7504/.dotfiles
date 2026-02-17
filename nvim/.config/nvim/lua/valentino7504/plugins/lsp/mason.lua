return {
	{
		"mason-org/mason.nvim",
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
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

			mason_lspconfig.setup({
				ensure_installed = {
					"html",
					"cssls",
					"omnisharp",
					"emmet_ls",
					"lua_ls",
					"basedpyright",
					"gopls",
					-- "jdtls",
					"docker_compose_language_service",
					"dockerls",
					"ts_ls",
					"rust_analyzer",
				},
			})

			mason_tool_installer.setup({
				ensure_installed = {
					"stylua",
					"golangci-lint",
					"prettier",
					"eslint_d",
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
}

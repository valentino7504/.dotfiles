return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"html",
				"cssls",
				"omnisharp",
				"emmet_ls",
				"lua_ls",
				"gopls",
				"ty",
				"docker_compose_language_service",
				"dockerls",
				"ts_ls",
				"rust_analyzer",
			},
			-- Manual installs - formatters:
			-- stylua, golangci-lint, prettier, biome, ruff, beautysh, checkmake, gofumpt, goimports, hadolint
		},
	},
}

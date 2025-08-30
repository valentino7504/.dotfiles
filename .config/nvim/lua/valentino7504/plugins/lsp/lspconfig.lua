return {
	"neovim/nvim-lspconfig",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	dependencies = {
		"saghen/blink.cmp",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_root = vim.fn.stdpath("data") .. "/mason/packages/" --[[@as string]]
		local keymap = vim.keymap -- for conciseness
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }
				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
				opts.desc = "Rename symbol"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", function()
					vim.lsp.buf.hover({ border = "single" })
				end, opts) -- show documentation for what is under cursor
				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		vim.diagnostic.config({
			float = { border = "single" },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
				},
				numhl = {
					[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
					[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
					[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
					[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
				},
			},
		})

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["basedpyright"] = function()
				lspconfig["basedpyright"].setup({
					settings = {
						basedpyright = {
							analysis = {
								-- uncomment the following line for loosey goosey code
								-- typeCheckingMode = "off",
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "openFilesOnly",
							},
						},
					},
				})
			end,
			["emmet_ls"] = function()
				-- configure emmet language server
				lspconfig["emmet_ls"].setup({
					capabilities = capabilities,
					filetypes = {
						"html",
						"css",
						"sass",
						"scss",
						"less",
						"svelte",
						"gotmpl",
					},
				})
			end,
			["omnisharp"] = function()
				-- configure omnisharp for dotnet
				lspconfig["omnisharp"].setup({
					cmd = { "dotnet", mason_root .. "omnisharp/libexec/OmniSharp.dll" },
					capabilities = capabilities,
					settings = {
						FormattingOptions = {
							OrganizeImports = true,
						},
					},
				})
			end,
			["ts_ls"] = function()
				-- configure ts_ls as this is the only JS LSP that helps
				lspconfig["ts_ls"].setup({
					capabilities = capabilities,
					filetypes = {
						"typescript",
						"typescriptreact",
						"javascriptreact",
						"javascript",
					},
					handlers = {
						["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
							local uri = result.uri
							local filetype = vim.api.nvim_buf_get_option(vim.uri_to_bufnr(uri), "filetype")
							-- Only process diagnostics for TypeScript files
							if filetype == "typescript" or filetype == "typescriptreact" then
								vim.lsp.handlers["textDocument/publishDiagnostics"](_, result, ctx, config)
							end
						end,
					},
				})
			end,
			["gopls"] = function()
				lspconfig["gopls"].setup({
					capabilities = capabilities,
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					settings = {
						gopls = {
							completeFunctionCalls = false,
						},
					},
				})
			end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim", "Snacks" },
							},
							runtime = {
								version = "LuaJIT",
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
		})
	end,
}

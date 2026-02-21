vim.lsp.config("ts_ls", {
	filetypes = {
		"typescript",
		"typescriptreact",
		"javascriptreact",
		"javascript",
	},
	handlers = {
		["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
			local uri = result.uri
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = vim.uri_to_bufnr(uri) })
			-- Only process diagnostics for TypeScript files
			if filetype == "typescript" or filetype == "typescriptreact" then
				vim.lsp.handlers["textDocument/publishDiagnostics"](_, result, ctx, config)
			end
		end,
	},
})

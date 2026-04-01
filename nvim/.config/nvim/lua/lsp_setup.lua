-- Define servers that are allowed to show inlay hints
local hint_allowed_list = {
	["ty"] = true,
	["rust_analyzer"] = true,
	["gopls"] = true,
}

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = args.buf
		-- Check if the current server is in our allowed list
		if client == nil then
			return
		end
		client.server_capabilities.semanticTokensProvider = nil
		if hint_allowed_list[client.name] then
			if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end
		end
	end,
})

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = false, -- these two are off because of tiny inline diagnostics
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

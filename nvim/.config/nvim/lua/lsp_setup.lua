-- Define servers that are allowed to show inlay hints
local hint_allowed_list = {
	["ty"] = true,
	["rust_analyzer"] = true,
}

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = args.buf

		-- Check if the current server is in our allowed list
		if client == nil then
			return
		end
		if hint_allowed_list[client.name] then
			if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end
		end
	end,
})

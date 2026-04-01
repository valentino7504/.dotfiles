return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			go = { "golangcilint" },
			javascript = { "biomejs" },
			typescript = { "biomejs" },
			javascriptreact = { "biomejs" },
			typescriptreact = { "biomejs" },
		}
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "BufReadPost" }, {
			group = lint_augroup,
			callback = function()
				local ft = vim.bo.filetype
				if lint.linters_by_ft[ft] then
					lint.try_lint()
				end
			end,
		})
		vim.keymap.set("n", "<leader>lf", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}

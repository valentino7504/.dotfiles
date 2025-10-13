return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		local normalize_list = function(t)
			local normalized = {}
			for _, v in pairs(t) do
				if v ~= nil then
					table.insert(normalized, v)
				end
			end
			return normalized
		end

		vim.keymap.set("n", "<leader>fh", function()
			Snacks.picker({
				finder = function()
					local file_paths = {}
					local list = normalize_list(harpoon:list().items)
					for _, item in ipairs(list) do
						table.insert(file_paths, { text = item.value, file = item.value })
					end
					return file_paths
				end,
				win = {
					input = {
						keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
					},
					list = {
						keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
					},
				},
				actions = {
					harpoon_delete = function(picker, item)
						local to_remove = item or picker:selected()
						harpoon:list():remove({ value = to_remove.text })
						harpoon:list().items = normalize_list(harpoon:list().items)
						picker:find({ refresh = true })
					end,
				},
			})
		end, { desc = "Harpoon Items" })

		vim.keymap.set("n", "<leader>hh", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Toggle Harpoon menu" })
		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end, { desc = "Add to Harpoon" })
		vim.keymap.set("n", "<leader>h1", function()
			harpoon:list():select(1)
		end, { desc = "Jump to the file 1 in the Harpoon menu" })
		vim.keymap.set("n", "<leader>h2", function()
			harpoon:list():select(2)
		end, { desc = "Jump to the file 2 in the Harpoon menu" })
		vim.keymap.set("n", "<leader>h3", function()
			harpoon:list():select(3)
		end, { desc = "Jump to the file 3 in the Harpoon menu" })
		vim.keymap.set("n", "<leader>h4", function()
			harpoon:list():select(4)
		end, { desc = "Jump to the file 4 in the Harpoon menu" })

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>hp", function()
			harpoon:list():prev()
		end, { desc = "Navigate to previous file in Harpoon menu" })
		vim.keymap.set("n", "<leader>hn", function()
			harpoon:list():next()
		end, { desc = "Navigate to next file in Harpoon menu" })
	end,
}

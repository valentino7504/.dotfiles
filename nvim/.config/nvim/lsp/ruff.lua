return {
	init_options = {
		settings = {
			-- Pass your specific strictness flags directly to the server
			lint = {
				select = { "E", "F", "ANN" }, -- Enable Flake8-Annotations
			},
		},
	},
}

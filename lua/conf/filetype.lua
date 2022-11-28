require("filetype").setup({
	overrides = {
		function_extensions = {
			["yml"] = function()
				if vim.fn.search("{{.+}}") then
					vim.bo.filetype = "gotmpl"
				end
			end,
			["yaml"] = function()
				if vim.fn.search("{{.+}}") then
					vim.bo.filetype = "gotmpl"
				end
			end,
			["tpl"] = function()
				if vim.fn.search("{{.+}}") then
					vim.bo.filetype = "gotmpl"
				end
			end,
		},
		function_literal = {
			Brewfile = function()
				vim.lsp.diagnostic.disable()
			end,
		},
	},
})

require("filetype").setup({
	overrides = {
	--	extensions = {
	--		-- Set the filetype of *.pn files to potion
	--		tpl = "tpl",
	--	},
		-- The same as the ones above except the keys map to functions
		function_extensions = {
			["tpl"] = function()
				if vim.fn.search("{{.+}}") then
					vim.bo.filetype = "gotmpl"
				end
			end,
			["yaml"] = function()
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

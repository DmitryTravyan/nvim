local function find_gompl_pattern()
	return string.match(
		table.concat(vim.api.nvim_buf_get_lines(tonumber(vim.fn.bufnr("%")), 0, -1, false), " "),
		"{{.+}}"
	)
end

require("filetype").setup({
	overrides = {
		function_complex = {
			[".*\\/templates\\/.*[.yml|.yaml]"] = function()
				if find_gompl_pattern() then
                    print('gotmpl')
					vim.bo.filetype = "gotmpl"
				else
					vim.bo.filetype = "yaml"
				end
			end,
		},
		function_extensions = {
			["tpl"] = function()
				if find_gompl_pattern() then
					vim.bo.filetype = "gotmpl"
				end
			end,
			["txt"] = function()
				if find_gompl_pattern() then
					vim.bo.filetype = "gotmpl"
				else
					vim.bo.filetype = "txt"
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

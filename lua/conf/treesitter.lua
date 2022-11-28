local configs_ok, configs = pcall(require, "nvim-treesitter.configs")
if not configs_ok then
	print("Error then calling 'nvim-treesitter.configs'")
	return
end

local parser_ok, parser_config = pcall(require, "nvim-treesitter.parsers")
if not parser_ok then
	print("Error then calling 'nvim-treesitter.parsers.get_parser_configs()'")
	return
end

parser_config.get_parser_configs().gotmpl = {
	install_info = {
		url = "https://github.com/ngalaiko/tree-sitter-go-template",
		files = { "src/parser.c" },
	},
	filetype = "gotmpl",
	used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" },
}

configs.setup({
	ensure_installed = {
		"c",
		"lua",
		"rust",
		"yaml",
		"haskell",
		"toml",
		"json",
		"hcl",
		"go",
		"gomod",
        "gotmpl",
		"sql",
		"ruby",
	},
	-- install languages synchronously (only applied to `ensure_installed`)
	sync_install = true,
	-- List of parsers to ignore installing
	-- ignore_install = "all",
	autopairs = {
		enable = true,
	},
	highlight = {
		-- false will disable the whole extension
		enable = true,
		-- list of language that will be disabled
		additional_vim_regex_highlighting = true,
		disable = { "rust", "go", "lua" },
	},
	indent = { enable = true, disable = { "yaml" } },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})


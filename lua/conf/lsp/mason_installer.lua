SERVERS = {
    -- Lsp servers
    "sumneko_lua",
    "rust_analyzer",
    "gopls",
    "jsonls",
    "terraformls",
    "tsserver",
    "yamlls",
    "golangci_lint_ls",
    "solargraph",
    "sorbet",
}

local tools = {
    -- Lua tools
    "luacheck",
    "stylua",
    "luaformatter",
    -- Go tools
    "gofumpt",
    "golines",
    "gomodifytags",
    "gotests",
    "go-debug-adapter",
    "golangci-lint",
    "goimports",
    "delve",
    "djlint",
    "impl",
    "json-to-struct",
    "revive",
    "staticcheck",
    -- Null ls tools
    "prettier",
    "black",
    "shfmt",
    "shellcheck",
}

require('mason-tool-installer').setup {
    ensure_installed = vim.tbl_deep_extend("force", SERVERS, tools),
    auto_update = false,
    run_on_start = true,
    start_delay = 3000, -- 3 second delay
}

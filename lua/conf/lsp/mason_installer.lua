local tools = {
    -- Lua tools
    "luacheck",
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
    -- Clang
    "clang-format",
}

require('mason-tool-installer').setup {
    ensure_installed = tools,
    auto_update = false,
    run_on_start = true,
    start_delay = 3000, -- 3 second delay
}

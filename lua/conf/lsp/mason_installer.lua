require('mason-tool-installer').setup {
    ensure_installed = {
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
        "goimports-reviser",
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
    },
    auto_update = false,
    run_on_start = true,
    start_delay = 3000, -- 3 second delay
}

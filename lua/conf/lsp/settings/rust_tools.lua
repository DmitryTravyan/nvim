return {
    tools = {
        autoSetHints = true,
        inlay_hints = {
            only_current_line = false,

            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",

            max_len_align = false,
            right_align = false,

            highlight = "Comment",
            cache = true,
        },
        hover_actions = {
            auto_focus = false,
            border = "rounded",
            width = 60,
            height = 30,
        },
    },
    server = {
        on_attach = require("conf.lsp.handlers").on_attach,
        capabilities = require("conf.lsp.handlers").capabilities,
        -- on_init = function(client)
        --     local toolchains = ""
        --     local path = client.workspace_folders[1].name
        --     print(path)

        --     if path == '/path/to/project1' then
        --         client.config.settings["rust-analyzer"].checkOnSave.overrideCommand = { "cargo", "check" }
        --     elseif path == '/path/to/rust' then
        --         client.config.settings["rust-analyzer"].checkOnSave.overrideCommand = { "python3", "x.py", "check",
        --             "--stage", "1" }
        --     end

        --     client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        --     return true
        -- end,

        cmd = {
            "rustup",
            "run",
            "stable",
            "rust-analyzer",
        },
        settings = {
            ["rust-analyzer"] = {
                -- lens = {
                --     enable = true,
                -- },
                -- enable clippy diagnostics on save
                checkOnSave = {
                    command = "clippy"
                },
                procMacro = {
                    enable = true
                },
                completion = {
                    postfix = {
                        enable = false
                    },
                },
                diagnostics = {
                    experimental = true,
                },
            },

        },
    },
}

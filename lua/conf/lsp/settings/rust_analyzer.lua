return {
    -- rust-tools options
    tools = {
        autoSetHints = true,
        hover_with_actions = true,

        inlay_hints = {
            only_current_line = false,

            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",

            max_len_align = false,
            right_align = false,

            highlight = "Comment",
        },
    },
    settings = {
        -- to enable rust-analyzer settings visit:
        -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ["rust-analyzer"] = {
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
        }
    },
}

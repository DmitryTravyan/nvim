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
    }
}


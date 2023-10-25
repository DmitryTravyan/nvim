return {
	tools = {
		autoSetHints = true,
		inlay_hints = {
			only_current_line = false,

			show_parameter_hints = true,
			parameter_hints_prefix = '<- ',
			other_hints_prefix = '=> ',

			max_len_align = false,
			right_align = false,

			highlight = 'Comment',
			cache = true,
		},
		hover_actions = {
			auto_focus = false,
			border = 'rounded',
			width = 60,
			height = 30,
		},
	},
	server = {
		cmd = {
			'rustup',
			'run',
			'stable',
			'rust-analyzer',
		},
		settings = {
			['rust-analyzer'] = {
				lens = {
					enable = true,
				},
				-- enable clippy diagnostics on save
				checkOnSave = {
					command = 'clippy',
				},
				procMacro = {
					enable = true,
				},
				completion = {
					postfix = {
						enable = false,
					},
				},
				diagnostics = {
					experimental = true,
				},
				cargo = {
					features = 'all',
				},
			},
		},
	},
}

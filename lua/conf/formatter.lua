local ok, util = pcall(require, "formatter.util")
if not ok then
	print("Error then calling require 'formatter' plugin")
	return
end

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.INFO,
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
			function()
				-- Full specification of configurations is down below and in Vim help
				-- files
				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},
		yaml = {
			require("formatter.filetypes.yaml").prettier,
		},
		terraform = {
			function()
				vim.lsp.buf.format()
			end,
		},
	},
})

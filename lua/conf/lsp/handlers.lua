local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

return {
	setup = function()
		local signs = {
			{ name = "DiagnosticSignError", text = "" },
			{ name = "DiagnosticSignWarn", text = "" },
			{ name = "DiagnosticSignHint", text = "" },
			{ name = "DiagnosticSignInfo", text = "" },
		}

		for _, sign in ipairs(signs) do
			vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
		end

		vim.diagnostic.config({
			virtual_text = true,
			signs = { active = signs },
			update_in_insert = true,
			underline = false,
			severity_sort = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
			},
			virtual_lines = false,
		})

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
		})

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "rounded",
		})

		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			virtual_text = true,
			signs = { active = signs },
			update_in_insert = true,
			virtual_lines = false,
		})
	end,

	on_attach = function(client, bufnr)
		if client.name == "tsserver" then
			client.resolved_capabilities.document_formatting = false
		end
		client.server_capabilities.semanticTokensProvider = nil

		local api = require("nvim-tree.api")

		local function opts(module, desc)
			return { desc = module .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end

		-- Default mappings. Feel free to modify or remove as you wish.
		--
		-- BEGIN_DEFAULT_ON_ATTACH
		vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("nvim-tree: ", "CD"))
		vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("nvim-tree: ", "Open: In Place"))
		vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("nvim-tree: ", "Info"))
		vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("nvim-tree: ", "Rename: Omit Filename"))
		vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("nvim-tree: ", "Open: New Tab"))
		vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("nvim-tree: ", "Open: Vertical Split"))
		vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("nvim-tree: ", "Open: Horizontal Split"))
		vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("nvim-tree: ", "Close Directory"))
		vim.keymap.set("n", "<CR>", api.node.open.edit, opts("nvim-tree: ", "Open"))
		vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("nvim-tree: ", "Open Preview"))
		vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("nvim-tree: ", "Next Sibling"))
		vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("nvim-tree: ", "Previous Sibling"))
		vim.keymap.set("n", ".", api.node.run.cmd, opts("nvim-tree: ", "Run Command"))
		vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("nvim-tree: ", "Up"))
		vim.keymap.set("n", "a", api.fs.create, opts("nvim-tree: ", "Create"))
		vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("nvim-tree: ", "Move Bookmarked"))
		vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("nvim-tree: ", "Toggle No Buffer"))
		vim.keymap.set("n", "c", api.fs.copy.node, opts("nvim-tree: ", "Copy"))
		vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("nvim-tree: ", "Toggle Git Clean"))
		vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("nvim-tree: ", "Prev Git"))
		vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("nvim-tree: ", "Next Git"))
		vim.keymap.set("n", "d", api.fs.remove, opts("nvim-tree: ", "Delete"))
		vim.keymap.set("n", "D", api.fs.trash, opts("nvim-tree: ", "Trash"))
		vim.keymap.set("n", "E", api.tree.expand_all, opts("nvim-tree: ", "Expand All"))
		vim.keymap.set("n", "e", api.fs.rename_basename, opts("nvim-tree: ", "Rename: Basename"))
		vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("nvim-tree: ", "Next Diagnostic"))
		vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("nvim-tree: ", "Prev Diagnostic"))
		vim.keymap.set("n", "F", api.live_filter.clear, opts("nvim-tree: ", "Clean Filter"))
		vim.keymap.set("n", "f", api.live_filter.start, opts("nvim-tree: ", "Filter"))
		vim.keymap.set("n", "g?", api.tree.toggle_help, opts("nvim-tree: ", "Help"))
		vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("nvim-tree: ", "Copy Absolute Path"))
		vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("nvim-tree: ", "Toggle Dotfiles"))
		vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("nvim-tree: ", "Toggle Git Ignore"))
		vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("nvim-tree: ", "Last Sibling"))
		vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("nvim-tree: ", "First Sibling"))
		vim.keymap.set("n", "m", api.marks.toggle, opts("nvim-tree: ", "Toggle Bookmark"))
		vim.keymap.set("n", "o", api.node.open.edit, opts("nvim-tree: ", "Open"))
		vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("nvim-tree: ", "Open: No Window Picker"))
		vim.keymap.set("n", "p", api.fs.paste, opts("nvim-tree: ", "Paste"))
		vim.keymap.set("n", "P", api.node.navigate.parent, opts("nvim-tree: ", "Parent Directory"))
		vim.keymap.set("n", "q", api.tree.close, opts("nvim-tree: ", "Close"))
		vim.keymap.set("n", "r", api.fs.rename, opts("nvim-tree: ", "Rename"))
		vim.keymap.set("n", "R", api.tree.reload, opts("nvim-tree: ", "Refresh"))
		vim.keymap.set("n", "s", api.node.run.system, opts("nvim-tree: ", "Run System"))
		vim.keymap.set("n", "S", api.tree.search_node, opts("nvim-tree: ", "Search"))
		vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("nvim-tree: ", "Toggle Hidden"))
		vim.keymap.set("n", "W", api.tree.collapse_all, opts("nvim-tree: ", "Collapse"))
		vim.keymap.set("n", "x", api.fs.cut, opts("nvim-tree: ", "Cut"))
		vim.keymap.set("n", "y", api.fs.copy.filename, opts("nvim-tree: ", "Copy Name"))
		vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("nvim-tree: ", "Copy Relative Path"))
		vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("nvim-tree: ", "Open"))
		vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("nvim-tree: ", "CD"))
		-- END_DEFAULT_ON_ATTACH

		-- Mappings migrated from view.mappings.list
		--
		-- You will need to insert "your code goes here" for any mappings with a custom action_cb
		vim.keymap.set("n", "l", api.node.open.edit, opts("nvim-tree: ", "Open"))
		vim.keymap.set("n", "<CR>", api.node.open.edit, opts("nvim-tree: ", "Open"))
		vim.keymap.set("n", "o", api.node.open.edit, opts("nvim-tree: ", "Open"))
		vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("nvim-tree: ", "Close Directory"))

		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"gD",
			"<cmd>lua vim.lsp.buf.declaration()<CR>",
			opts("lsp: ", "Buffer Declaration")
		)
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"gd",
			"<cmd>lua vim.lsp.buf.definition()<CR>",
			opts("lsp: ", "Buffer Definition")
		)

		-- Show hover
		vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts("lsp: ", "Buffer Hover"))

		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"gi",
			"<cmd>lua vim.lsp.buf.implementation()<CR>",
			opts("lsp: ", "Buffer Implementation")
		)
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"<C-k>",
			"<cmd>lua vim.lsp.buf.signature_help()<CR>",
			opts("lsp: ", "Buffer Signature")
		)
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"<leader>rn",
			"<cmd>lua vim.lsp.buf.rename()<CR>",
			opts("lsp: ", "Buffer Rename")
		)
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"gr",
			"<cmd>lua vim.lsp.buf.references()<CR>",
			opts("lsp: ", "Buffer Reference")
		)

		-- Open code action menu
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"ga",
			"<cmd>lua vim.lsp.buf.code_action()<CR>",
			opts("lsp: ", "Buffer Code Action")
		)

		-- Open float window with diagnostic
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"t",
			'<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',
			opts("lsp: ", "Buffer Open Float")
		)
		-- Go to next error (diagnostic action)
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"]d",
			'<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
			opts("lsp: ", "Buffer Goto Next")
		)

		-- Go to previose error (diagnostic action)
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"[d",
			'<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
			opts("lsp: ", "Buffer Goto Prev")
		)

		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"<leader>q",
			"<cmd>lua vim.diagnostic.setloclist()<CR>",
			opts("lsp: ", "Buffer Set Loginc")
		)

		-- vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
	end,

	capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

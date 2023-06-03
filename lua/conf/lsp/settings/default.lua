local cmp_nvim_lsp = require("cmp_nvim_lsp")

return {
	on_attach = function(client, bufnr)
		if client.name == "tsserver" then
			client.resolved_capabilities.document_formatting = false
		end
		client.server_capabilities.semanticTokensProvider = nil

		local api = require("nvim-tree.api")

		local function opts(module, desc)
			return { desc = module .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end

		-- =================================== TREE ===============================================
		vim.keymap.set("n", "<CR>", api.node.open.edit, opts("nvim-tree: ", "Open"))
		vim.keymap.set("n", "]", api.node.open.edit, opts("nvim-tree: ", "Open"))
		vim.keymap.set("n", "l", function()
			local x = api.node.open.edit
			print("api.node.open.edit")
		end, opts("nvim-tree: ", "Open"))
		vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("nvim-tree: ", "Close Directory"))

		-- =================================== LSP ================================================
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("lsp: ", "Buffer Declaration"))
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("lsp: ", "Buffer Definition"))

		-- Show hover
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("lsp: ", "Buffer Hover"))
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("lsp: ", "Buffer Implementation"))
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts("lsp: ", "Buffer Signature"))
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("lsp: ", "Buffer Rename"))
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("lsp: ", "Buffer Reference"))
		-- Open code action menu
		vim.keymap.set("n", "ga", vim.lsp.buf.code_action, opts("lsp: ", "Buffer Code Action"))

		-- Open float window with diagnostic
		vim.keymap.set("n", "t", function()
			vim.diagnostic.open_float({ border = "rounded" })
		end, opts("lsp: ", "Buffer Open Float"))
		-- Go to next error (diagnostic action)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_next({ border = "rounded" })
		end, opts("lsp: ", "Buffer Goto Next"))

		-- Go to previose error (diagnostic action)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_prev({ border = "rounded" })
		end, opts("lsp: ", "Buffer Goto Prev"))

		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts("lsp: ", "Buffer Set Loginc"))

		-- vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
	end,

	capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

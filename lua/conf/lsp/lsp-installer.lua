local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("conf.lsp.handlers").on_attach,
		capabilities = require("conf.lsp.handlers").capabilities,
	}

    if server.name == "jsonls" then
		local jsonls_opts = require("conf.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	if server.name == "sumneko_lua" then
		local sumneko_opts = require("conf.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end


    if server.name == "gopls" then
        local go_opts = require("conf.lsp.settings.gopls")
        opts = vim.tbl_deep_extend("force", go_opts, opts)
    end

	if server.name == "rust_analyzer" then
		-- Main configuration for lsp
        local rust_analyzer_opts = require("conf.lsp.settings.rust_analyzer")
        -- Initialize the LSP via rust-tools instead
        require("rust-tools").setup {
            -- The "server" property provided in rust-tools setup function are the
            -- settings rust-tools will provide to lspconfig during init.
            -- We merge the necessary settings from nvim-lsp-installer (server:get_default_options())
            -- with the user's own settings (opts).
            server = vim.tbl_deep_extend(
                "force",
                server:get_default_options(),
                opts,
                rust_analyzer_opts
            ),
        }
        server:attach_buffers()
    else
        server:setup(opts)
    end
end)


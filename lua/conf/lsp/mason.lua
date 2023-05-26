require("conf.lsp.mason_installer")

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
	print("Error then calling require 'lspconfig' plugin")
	return
end

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
	print("Error then calling require 'mason' plugin")
	return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
	print("Error then calling require 'mason-lspconfig' plugin")
	return
end

AUTO_INSTALL_SERVERS = {
	-- Lsp servers
	"lua_ls",
	"gopls",
	"jsonls",
	"terraformls",
	"tsserver",
	"yamlls",
	"golangci_lint_ls",
	"clangd",
	"pylyzer",
}

START_SERVERS = {
	-- Lsp servers
	"lua_ls",
	"rust_analyzer",
	"gopls",
	"jsonls",
	"terraformls",
	"tsserver",
	"yamlls",
	"golangci_lint_ls",
	"clangd",
	"pylyzer",
}

mason.setup({
	ui = {
		border = "rounded",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 1,
})

mason_lspconfig.setup({
	ensure_installed = AUTO_INSTALL_SERVERS,
	automatic_installation = false,
})

local opts = {}

for _, server in pairs(START_SERVERS) do
	-- Options for lsp servers
	opts = {
		on_attach = require("conf.lsp.handlers").on_attach,
		capabilities = require("conf.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@", { plain = true })[1]

	if server == "jsonls" then
		local jsonls_opts = require("conf.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	if server == "yamlls" then
		local yamlls_opts = require("conf.lsp.settings.yamlls")
		opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
	end

	if server == "lua_ls" then
		local n_status_ok, neodev = pcall(require, "neodev")
		if not n_status_ok then
			print("error then calling require plugin folke/neodev.nvim")
			return
		end
		neodev.setup()
		local lua_status_ok, lua_opts = pcall(require, "conf.lsp.settings.lua_ls")
		if not lua_status_ok then
			print("error then calling require options for plugin lua_ls")
			return
		end
		opts = vim.tbl_deep_extend("force", opts, lua_opts)

		lspconfig.lua_ls.setup(opts)
		goto continue
	end

	if server == "tsserver" then
		local tsserver_opts = require("conf.lsp.settings.tsserver")
		opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
	end

	if server == "rust_analyzer" then
		local rust_opts_ok, rust_opts = pcall(require, "conf.lsp.settings.rust_tools")
		if not rust_opts_ok then
			print("Error then calling require 'conf/lsp/settings/rust_tools' script")
			return
		end

		local rust_tools_ok, rust_tools = pcall(require, "rust-tools")
		if not rust_tools_ok then
			print("Error then calling require 'rust-tools' plugin")
			return
		end

		rust_tools.setup(rust_opts)
		goto continue
	end

	if server == "gopls" then
		local gopls_opts = require("conf.lsp.settings.gopls")
		opts = vim.tbl_deep_extend("force", gopls_opts, opts)
	end

	if server == "clangd" then
		local clangd_opts = require("conf.lsp.settings.clangd")
		opts = vim.tbl_deep_extend("force", clangd_opts, opts)
	end

	if server == "pylyzer" then
		local pylyzer_opts = require("conf.lsp.settings.pylyzer")
		opts = vim.tbl_deep_extend("force", pylyzer_opts, opts)
	end

	lspconfig[server].setup(opts)
	::continue::
end

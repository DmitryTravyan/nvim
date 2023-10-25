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
	--"gopls",
	"jsonls",
	--"terraformls",
	"tsserver",
	"yamlls",
	--"golangci_lint_ls",
	"clangd",
	--"pylyzer",
}

START_SERVERS = {
	-- Lsp servers
	"lua_ls",
	"rust_analyzer",
	--"gopls",
	"jsonls",
	--"terraformls",
	"tsserver",
	"yamlls",
	--"golangci_lint_ls",
	"clangd",
	--"pylyzer",
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

local opts = require("conf.lsp.settings.default")

for _, server in pairs(START_SERVERS) do
	server = vim.split(server, "@", { plain = true })[1]

	if server == "jsonls" then
		local jsonls_opts = require("conf.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", opts, jsonls_opts)
	end

	if server == "yamlls" then
		local yamlls_opts = require("conf.lsp.settings.yamlls")
		opts = vim.tbl_deep_extend("force", opts, yamlls_opts)
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
		opts = vim.tbl_deep_extend("force", opts, tsserver_opts)
	end

	if server == "rust_analyzer" then
		local rust_opts_ok, rust_opts = pcall(require, "conf.lsp.settings.rust_tools")
		if not rust_opts_ok then
			print("Error then calling require 'conf/lsp/settings/rust_tools' script")
			return
		end

		rust_opts.server = vim.tbl_deep_extend("force", rust_opts.server, opts)
		opts = vim.tbl_deep_extend("force", opts, rust_opts)

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
		opts = vim.tbl_deep_extend("force", opts, gopls_opts)
	end

	if server == "clangd" then
		local clangd_opts = require("conf.lsp.settings.clangd")
		opts = vim.tbl_deep_extend("force", opts, clangd_opts)
	end

	if server == "pylyzer" then
		local pylyzer_opts = require("conf.lsp.settings.pylyzer")
		opts = vim.tbl_deep_extend("force", opts, pylyzer_opts)
	end

	lspconfig[server].setup(opts)
	::continue::
end

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

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    print("Error then calling require 'lspconfig' plugin")
    return
end

-- list of important lsp servers
servers = {
    -- LSP servers
    "sumneko_lua",
    "rust_analyzer",
    "gopls",
    "jsonls",
    "terraformls",
    "tsserver",
    "yamlls",
    "golangci_lint_ls", 
}

-- manual installed
-- luaformatter
-- luacheck
-- go-dap

local status_ok, mason = pcall(require, "mason")
if not status_ok then
    print("Error then calling require 'mason' plugin")
    return
end

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
    print("Error then calling require 'mason-lspconfig' plugin")
    return
end

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
    ensure_installed = servers,
    automatic_installation = false,
})

local opts = {}

for _, server in pairs(servers) do
  -- Options for lsp servers
  opts = {
      on_attach = require("conf.lsp.handlers").on_attach,
      capabilities = require("conf.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  if server == "jsonls" then
    local jsonls_opts = require "conf.lsp.settings.jsonls"
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server == "yamlls" then
    local yamlls_opts = require "conf.lsp.settings.yamlls"
    opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
  end

  if server == "sumneko_lua" then
    local l_status_ok, lua_dev = pcall(require, "lua-dev")
    if not l_status_ok then
      return
    end
    -- local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    -- opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    -- opts = vim.tbl_deep_extend("force", require("lua-dev").setup(), opts)
    local luadev = lua_dev.setup {
      --   -- add any options here, or leave empty to use the default settings
      -- lspconfig = opts,
      lspconfig = {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        --   -- settings = opts.settings,
      },
    }
    lspconfig.sumneko_lua.setup(luadev)
    goto continue
  end

  if server == "tsserver" then
    local tsserver_opts = require "conf.lsp.settings.tsserver"
    opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
  end

  if server == "rust_analyzer" then
    local rust_opts = require "conf.lsp.settings.rust_analyzer"
    -- opts = vim.tbl_deep_extend("force", rust_opts, opts)
    local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
    if not rust_tools_status_ok then
      return
    end

    if server == "gopls" then
        local gopls_opts = require "conf.lsp.settings.gopls"
        opts = vim.tbl_deep_extend("force", gopls_opts, opts)
    end

    rust_tools.setup(rust_opts)
    goto continue
  end

  lspconfig[server].setup(opts)
  ::continue::
end

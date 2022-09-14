local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    print("Error then calling require 'lspconfig' plugin")
    return
end

require("conf.lsp.mason")
require("conf.lsp.null_ls")
require("conf.lsp.handlers").setup()

local status_ok, lsp_lines = pcall(require, "lsp_lines")
if not status_ok then 
    print("Error then calling require 'lsp-lines' plugin")
end

lsp_lines.setup()

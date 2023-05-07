local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
-- local servers = { "html", "cssls", "clangd"}
local servers = { 'clangd', 'bashls', 'pyright', 'dockerls', 'golangci_lint_ls', 'html', 'jsonls', 'sqlls', "lua_ls", }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


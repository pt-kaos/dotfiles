"Setup Language Servers
lua << EOF
require'lspconfig'.bashls.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.golangci_lint_ls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.pyright.setup{}
require'lspconfig'.sqlls.setup{}




EOF

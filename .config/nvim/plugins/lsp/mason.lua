local mason_status, mason = pcall(require, "mason")
if not mason_status then return end

local masonlsp_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not masonlsp_status then return end

mason.setup()

mason_lspconfig.setup({
    ensure_installed = {
        "sumneko_lua",
        "golangci_lint_ls",
        "clangd",
        "bashls",
        "dockerls",
        "jsonls",
        "pyright",
        "sqlls",
        "html",
    }
})



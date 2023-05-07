-- require("nvterm").setup({
--     terminals = {
--         type_opts = {
--             float = {
--                 relative = 'editor',
--                 row = 0.1,
--                 col = 0.1,
--                 width = 0.8,
--                 height = 0.7,
--                 border = "single",
--             },
--         }
--     }
-- })

local g = vim.g

local plugins = {
    -- In order to modify the `lspconfig` configuration:
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end,
    },

    -- Terminal Plugin
    { 'voldikss/vim-floaterm',
        config = function ()
            g.floaterm_keymap_toggle = '<F6>'  -- <F1> is in use for the help
            g.floaterm_keymap_next   = '<F7>'
            g.floaterm_keymap_prev   = '<F8>'
            g.floaterm_keymap_new    = '<F9>'
            g.floaterm_gitcommit     = 'floaterm'
            g.floaterm_autoinsert    = 1
            g.floaterm_width         = 0.8
            g.floaterm_height        = 0.8
            g.floaterm_wintitle      = 0
            g.floaterm_autoclose     = 1
        end,
        lazy = false
    },  -- A floating Terminal plugin -> A Must Have!
-- let g:floaterm_keymap_toggle = '<F1>'
-- let g:floaterm_keymap_next   = '<F2>'
-- let g:floaterm_keymap_prev   = '<F3>'
-- let g:floaterm_keymap_new    = '<F4>'
--
-- let g:floaterm_gitcommit='floaterm'
-- let g:floaterm_autoinsert=1
-- let g:floaterm_width=0.8
-- let g:floaterm_height=0.8
-- let g:floaterm_wintitle=0
-- let g:floaterm_autoclose=1
--
-- augroup FloatermCustomisations
--     autocmd!
--     autocmd ColorScheme * highlight FloatermBorder guibg=none
-- augroup END

    -- Pattern Search
    { 'BurntSushi/ripgrep', lazy = true },

    -- Dracula Theme
    { 'dracula/vim', name = 'dracula', lazy = false },

    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
             --   "sumneko_lua",
                "golangci-lint-langserver",
                "clangd",
                "bash-language-server",
                "docker-compose-language-service",
                "dockerfile-language-server",
                "json-lsp",
                "pyright",
                "sqlls",
             --   "html",
                "lua-language-server",
                "html-lsp",
                "prettier",
                "stylua",
            }
        }
    },
--    {
--        "NvChad/nvterm",
--        type_opts = {
--            float = {
--                relative = 'editor',
--                row = 0.1,
--                col = 0.1,
--                width = 0.9,
--                height = 0.9,
--                border = "single",
--            },
--        },
--    },
}

return plugins

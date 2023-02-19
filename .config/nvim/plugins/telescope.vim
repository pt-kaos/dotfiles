"Plug 'https://github.com/nvim-lua/plenary.nvim'
"Plug 'https://github.com/nvim-telescope/telescope.nvim'
"Plug 'https://github.com/nvim-telescope/telescope-fzf-native.nvim'
"Plug 'https://github.com/BurntSushi/ripgrep'

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

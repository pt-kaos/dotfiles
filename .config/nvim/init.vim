" This configuration file is based on Jess Archer configuration file.
" https://github.com/jessarcher/dotfiles/blob/master/nvim/init.vim
"--------------------------------------------------------------------------
" Plugins
"--------------------------------------------------------------------------

source ~/.config/nvim/plugins-setup.vim

"--------------------------------------------------------------------------
" General settings
"--------------------------------------------------------------------------
source ~/.config/nvim/core/options.vim

"--------------------------------------------------------------------------
" Key maps
"--------------------------------------------------------------------------
source ~/.config/nvim/core/keymaps.vim

"--------------------------------------------------------------------------
" Setup Loaded Plugins
"--------------------------------------------------------------------------

source ~/.config/nvim/plugins/airline.vim
source ~/.config/nvim/plugins/arduino.vim
source ~/.config/nvim/plugins/autopairs.vim
source ~/.config/nvim/plugins/chatgpt.lua
source ~/.config/nvim/plugins/floaterm.vim
source ~/.config/nvim/plugins/hexokinase.vim
source ~/.config/nvim/plugins/nerdtree.vim
source ~/.config/nvim/plugins/snippets.vim
source ~/.config/nvim/plugins/tagbar.vim
source ~/.config/nvim/plugins/telescope.vim
luafile ~/.config/nvim/plugins/dracula.lua
luafile ~/.config/nvim/plugins/nvim-cmp.lua
luafile ~/.config/nvim/plugins/lsp/mason.lua
luafile ~/.config/nvim/plugins/lsp/lspconfig.lua
luafile ~/.config/nvim/plugins/lsp/lspsaga.lua


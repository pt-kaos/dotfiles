" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugins')

" Setup Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Setup arduino Plugin
Plug 'stevearc/vim-arduino'         "{'for': 'clang'}

" Setup Comentary plugin - comments lines and paragraphs acording to the file type 
Plug 'tpope/vim-commentary'
Plug 'suy/vim-context-commentstring'    "Complements the commentary plugin with some automation like auto comments after newline

" surround anything with characters we chose
Plug 'tpope/vim-surround'

" Autopair opening characters with it's closing equivalent
Plug 'jiangmiao/auto-pairs'

" Completion Plugins
Plug 'hrsh7th/nvim-cmp'                 "A completion Engine for NeoVim
Plug 'hrsh7th/cmp-nvim-lsp'             "The completion Pluggin - Allow LSP completions -> A Must Have!
Plug 'hrsh7th/cmp-buffer'               "Buffer completins
Plug 'hrsh7th/cmp-path'                 "Path completions
Plug 'hrsh7th/cmp-cmdline'              "Command line completions
Plug 'saadparwaiz1/cmp_luasnip'         "Snippet completions
Plug 'glepnir/lspsaga.nvim'             "Enhance UI for LSP experience
Plug 'onsails/lspkind.nvim'             "Add vscode icons to lsp autocompletion window

" Snippets Plugins
Plug 'L3MON4D3/LuaSnip'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

" Terminal Plugin
Plug 'voldikss/vim-floaterm'            "A floating Terminal plugin -> A Must Have!

" Git wrapper and Extention
"Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-rhubarb'                "A Git Plugin extention for the fugitive Plugin

" LSP Plugins
Plug 'neovim/nvim-lspconfig'            " nvim LSP implementation
Plug 'williamboman/mason-lspconfig.nvim'          "An LSP Servers Installer
Plug 'williamboman/mason.nvim'          "An LSP Servers Installer


" File Browser Plugin
Plug 'preservim/nerdtree', {'on': ['NERDTree', 'NERDTreeToggle', 'NERDTreeFind', 'NERDTreeFocus']}     " Load NerdTree only when it's invoked for the first time using Toggle
Plug 'Xuyuanp/nerdtree-git-plugin'                      " a Plugin to show git status flags
Plug 'ryanoasis/vim-devicons'                           "Ads icons to plugins (Nertree, Airline, etc...)
Plug 'johnstef99/vim-nerdtree-syntax-highlight'          " Works with vim-devicons plugin - Adds syntax for nerdtree on most common file extentions
""Plug 'jcharum/vim-nerdtree-syntax-highlight'          " Works with vim-devicons plugin - Adds syntax for nerdtree on most common file extentions
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'          " Works with vim-devicons plugin - Adds syntax for nerdtree on most common file extentions

" A tag bar Plugin for code navigation
Plug 'preservim/tagbar', {'on': 'TagbarToggle'}         "Tagbar for code navigation

" Fuzzy Searcher Plugin
Plug 'nvim-lua/plenary.nvim'                            "Plugin required for Telescope
Plug 'nvim-telescope/telescope.nvim'                    "Extendable fuzzy finder
Plug 'nvim-telescope/telescope-fzf-native.nvim'         "The fuzzy finder itself
Plug 'BurntSushi/ripgrep'                               "Search for a pattern

" A Plugin to analyse vim startup performace (due to plugins time to load at 
" nvim startup)
Plug 'dstein64/vim-startuptime'                         "Identify plugin startup time to allow for optimization

" Color & Theme Plugin
Plug 'dracula/vim', { 'as': 'dracula' } "dracula theme
Plug 'RRethy/vim-hexokinase'            "colorize color descriptions or color codes



"source ~/.config/nvim/plugins/abolish.vim
"source ~/.config/nvim/plugins/coc.vim
"source ~/.config/nvim/plugins/dispatch.vim
"source ~/.config/nvim/plugins/editorconfig.vim
"source ~/.config/nvim/plugins/eunuch.vim
"source ~/.config/nvim/plugins/exchange.vim
"source ~/.config/nvim/plugins/firenvim.vim
"source ~/.config/nvim/plugins/fzf.vim
"source ~/.config/nvim/plugins/heritage.vim
"source ~/.config/nvim/plugins/lastplace.vim
"source ~/.config/nvim/plugins/lion.vim
"source ~/.config/nvim/plugins/markdown-preview.vim
"source ~/.config/nvim/plugins/pasta.vim
"source ~/.config/nvim/plugins/peekaboo.vim
"source ~/.config/nvim/plugins/phpactor.vim
"source ~/.config/nvim/plugins/polyglot.vim
"source ~/.config/nvim/plugins/projectionist.vim
"Plug 'airblade/vim-rooter'                              "Change the working directory to the project root when a file or directory is opened
"source ~/.config/nvim/plugins/quickscope.vim
"source ~/.config/nvim/plugins/repeat.vim
"source ~/.config/nvim/plugins/sayonara.vim
"source ~/.config/nvim/plugins/smooth-scroll.vim
"source ~/.config/nvim/plugins/splitjoin.vim
"source ~/.config/nvim/plugins/surround.vim
"source ~/.config/nvim/plugins/targets.vim
"source ~/.config/nvim/plugins/textobj-xmlattr.vim
"source ~/.config/nvim/plugins/tmux-navigator.vim
"source ~/.config/nvim/plugins/unimpaired.vim
"source ~/.config/nvim/plugins/vimawesome.vim
"source ~/.config/nvim/plugins/vim-test.vim
"source ~/.config/nvim/plugins/visual-multi.vim
"source ~/.config/nvim/plugins/visual-star-search.vim
"source ~/.config/nvim/plugins/which-key.vim


call plug#end()
doautocmd User PlugLoaded


"--------------------------------------------------------------------------
" General settings
"--------------------------------------------------------------------------
set expandtab
set shiftwidth=4
set tabstop=4
"set hidden
"set signcolumn=yes:2
set relativenumber
set number
set termguicolors
"set undofile
"set spell
set title
set ignorecase
set smartcase
set wildmode=longest:full,full	"Show list and iterate full completions
set infercase			        "Adjust completions to match case
"set nowrap
set list
set listchars=tab:▸\ ,trail:·
set mouse=a
set scrolloff=8
set sidescrolloff=8
"set nojoinspaces
"set splitright
set splitbelow
set clipboard=unnamedplus
"set confirm
"set exrc
"set backup
"set backupdir=~/.local/share/nvim/backup//
"set updatetime=300 " Reduce time for highlighting other references
"set redrawtime=10000 " Allow more time for loading syntax on large files
set backspace=indent,eol,start
set completeopt=menu,menuone,noselect

"--------------------------------------------------------------------------
" Miscellaneous
"--------------------------------------------------------------------------

highlight Comment term=bold cterm=italic ctermfg=white gui=italic guifg=white

augroup VimReload
autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC "Reload Vim Config
augroup END


" To have Vim jump to the last position when reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

autocmd TermOpen * startinsert

"augroup FileTypeOverrides
"    autocmd!
"    " Use '//' instead of '/* */' comments
"    autocmd FileType php setlocal commentstring=//%s
"    autocmd TermOpen * setlocal nospell
"augroup END

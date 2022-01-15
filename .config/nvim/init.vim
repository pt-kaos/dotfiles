" This configuration file is based on Jess Archer configuration file.
" https://github.com/jessarcher/dotfiles/blob/master/nvim/init.vim
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
"set termguicolors
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
" Key maps
"--------------------------------------------------------------------------

"let mapleader = "\<space>"
let mapleader = '\'

nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nmap <leader>vr :source ~/.config/nvim/init.vim<cr>

nmap <leader>k :nohlsearch<CR>
nmap <leader>Q :bufdo bdelete<cr>

" Allow gf to open non-existent files
map gf :edit <cfile><cr>

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" Maintain the cursor position when yanking a visual selection
" http://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap y myy`y
vnoremap Y myY`y

" When text is wrapped, move by terminal rows, not lines, unless a count is provided
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Paste replace visual selection without copying it
vnoremap <leader>p "_dP

" Make Y behave like the other capitals
nnoremap Y y$

" Keep it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Open the current file in the default program
nmap <leader>x :!xdg-open %<cr><cr>

" Quicky escape to normal mode
imap jj <esc>

" Easy insertion of a trailing ; or , from insert mode
imap ::: <Esc>A:<Esc>
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>

map <C-Tab> :bnext<cr>
map <C-S-Tab> :bprevious<cr>

" Comenta palavra com Aspas
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel<cr>
" Comenta palavra com Plicas
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel<cr>
" Comenta seleção com Aspas
vnoremap <leader>" :normal! `>a"<esc>`<i"<esc>`>el
" Comenta seleção com Plicas
vnoremap <leader>' :normal! `>a'<esc>`<i'<esc>`>el

" Shift-Tab in visual mode to number lines...
xnoremap <S-TAB> :s/\%V/0<C-V><TAB>/<CR>gvg<C-A>gv:retab<ESC>gvI<C-G>u<ESC>gv/ <CR>:s/\%V /./<CR>

" Go to tab by number
noremap <leader>1 :b1<cr>
noremap <leader>2 :b2<cr>
noremap <leader>3 :b3<cr>
noremap <leader>4 :b4<cr> 
noremap <leader>5 :b5<cr> 
noremap <leader>6 :b6<cr>
noremap <leader>7 :b7<cr>
noremap <leader>8 :b8<cr> 
noremap <leader>9 :b9<cr> 
noremap <leader>0 :tablast<cr>

map <buffer> <F9> :FloatermNew --autoclose=1 <CR>
imap <buffer> <F9> :FloatermNew --autoclose=1 <CR>

" PYTHON SPECIFIC
augroup filetype_python
        " Comenta Paragrafo ou bloco de codigo com #
        autocmd FileType python nnoremap <buffer> <leader>cc mm}k^m1{j<C-v>'1:normal! I#<esc>`ml
        " Atalho para comentar uma linha em pyton
        autocmd FileType python nnoremap <buffer> <leader>c I#<esc>
        " Não quero o wrapline na edição de ficheiros python
"        autocmd BufNewFile,BufRead *.py setlocal nowrap
"        autocmd FileType python :iabbrev <buffer> iff if():<left><left>
        " autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
        " autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
        " autocmd FileType python map <buffer> <F9> :w<CR>:sp<bar>ter python3 "%"<CR>
        " autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:sp<bar>ter python3 "%"<CR>
        autocmd FileType python map <buffer> <F5> :w<CR>:FloatermNew --autoclose=0 python3 "%"<CR>
        autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:FloatermNew --autoclose=0 python3 "%"<CR>
augroup END

"--------------------------------------------------------------------------
" Plugins
"--------------------------------------------------------------------------

" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugins')

"source ~/.config/nvim/plugins/abolish.vim
source ~/.config/nvim/plugins/airline.vim
source ~/.config/nvim/plugins/arduino.vim
source ~/.config/nvim/plugins/autopairs.vim
"source ~/.config/nvim/plugins/coc.vim
source ~/.config/nvim/plugins/commentary.vim
source ~/.config/nvim/plugins/cmp-nvim-lsp.vim
source ~/.config/nvim/plugins/cmp-buffer.vim
source ~/.config/nvim/plugins/cmp-path.vim
source ~/.config/nvim/plugins/cmp-cmdline.vim
source ~/.config/nvim/plugins/cmp-luasnip.vim
source ~/.config/nvim/plugins/context-commentstring.vim
source ~/.config/nvim/plugins/dispatch.vim
source ~/.config/nvim/plugins/dracula.vim
"source ~/.config/nvim/plugins/editorconfig.vim
"source ~/.config/nvim/plugins/eunuch.vim
"source ~/.config/nvim/plugins/exchange.vim
"source ~/.config/nvim/plugins/firenvim.vim
source ~/.config/nvim/plugins/floaterm.vim
source ~/.config/nvim/plugins/fugitive.vim
"source ~/.config/nvim/plugins/fzf.vim
"source ~/.config/nvim/plugins/heritage.vim
"source ~/.config/nvim/plugins/lastplace.vim
"source ~/.config/nvim/plugins/lion.vim
source ~/.config/nvim/plugins/lspconfig.vim
source ~/.config/nvim/plugins/nvim-cmp.vim
source ~/.config/nvim/plugins/LuaSnip.vim
"source ~/.config/nvim/plugins/markdown-preview.vim
source ~/.config/nvim/plugins/nerdtree.vim
"source ~/.config/nvim/plugins/pasta.vim
"source ~/.config/nvim/plugins/peekaboo.vim
"source ~/.config/nvim/plugins/phpactor.vim
"source ~/.config/nvim/plugins/polyglot.vim
"source ~/.config/nvim/plugins/projectionist.vim
"source ~/.config/nvim/plugins/quickscope.vim
"source ~/.config/nvim/plugins/repeat.vim
source ~/.config/nvim/plugins/rooter.vim
"source ~/.config/nvim/plugins/sayonara.vim
"source ~/.config/nvim/plugins/smooth-scroll.vim
source ~/.config/nvim/plugins/snippets.vim
"source ~/.config/nvim/plugins/splitjoin.vim
"source ~/.config/nvim/plugins/surround.vim
source ~/.config/nvim/plugins/tagbar.vim
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

source ~/.config/nvim/language-servers.vim
source ~/.config/nvim/nvim-cmp.vim

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

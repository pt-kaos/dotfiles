" keymap definitions
"--------------------------------------------------------------------------

"let mapleader = "\<space>"
let mapleader = '\'

" Edit nvim configuration file
nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>

" Source nvim configuration file to reflect changes
nmap <leader>vr :source ~/.config/nvim/init.vim<cr>

" Remove highliting after a search
nmap <leader>k :nohlsearch<CR>

" Close all buffers
nmap <leader>Q :bufdo bdelete<cr>
" Close the active buffer
nmap <leader>q :bdelete<cr>

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

" Delete character but don't put it in the clipboard
nnoremap x  "_x

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

" Move text/selection
map  <A-j> <Esc>:m .+1<CR>==gi
map  <A-k> <Esc>:m .-2<CR>==gi

"keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
"keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)


" Easy insertion of a trailing ':', ';' or ',' from insert mode
imap ::: <Esc>A:<Esc>
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>

nnoremap <C-x> :close<cr>

nnoremap <C-Tab> :bnext<cr>
nnoremap <C-S-Tab> :bprevious<cr>

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

" Go to buffer by number
noremap <leader>1 :b1<cr>
noremap <leader>2 :b2<cr>
noremap <leader>3 :b3<cr>
noremap <leader>4 :b4<cr>
noremap <leader>5 :b5<cr>
noremap <leader>6 :b6<cr>
noremap <leader>7 :b7<cr>
noremap <leader>8 :b8<cr>
noremap <leader>9 :b9<cr>
noremap <leader>0 :blast<cr>
noremap <leader>+ :bnext<cr>
noremap <leader>- :bprevious<cr>
"noremap <leader>+ <Plug>AirlineSelectNextTab
"noremap <leader>- <Plug>AirlineSelectPrevTab
"
"keymaps for tabs (not buffers)
"noremap <leader>tn :tabnew<CR>
"noremap <leader>tx :tabclose<CR>
"noremap <leader>+ :tabn<CR>
"noremap <leader>- :tabp<CR>

"Clipboard
" Copy to clipboard
vnoremap  <leader>y  "+yy
nnoremap  <leader>Y  "+yg_
"nnoremap  <leader>y  "+yy
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Remove trailing White Spaces
nnoremap <leader>sws :%s/\s\+$//<CR>

"LSP Formating:
nnoremap <leaded>lf :lua vim.lsp.buf.format()

" Chat GPT Plugin
nnoremap <leader>tk :ChatGPT
vnoremap <leader>tk :ChatGPT
nnoremap <leader>tj :ChatGPTActAs
vnoremap <leader>tj :ChatGPTActAs
nnoremap <leader>tt :ChatGPTEditWithInstructions
vnoremap <leader>tt :ChatGPTEditWithInstructions

"
"
" PYTHON SPECIFIC
augroup filetype_python
        " Comenta Paragrafo ou bloco de codigo com #
        autocmd FileType python nnoremap <buffer> <leader>cc mm}k^m1{j<C-v>'1:normal! I#<esc>`ml

        " Atalho para comentar uma linha em pyton
        autocmd FileType python nnoremap <buffer> <leader>c I#<esc>

        " Não quero o wrapline na edição de ficheiros python
"        autocmd BufNewFile,BufRead *.py setlocal nowrap
"        autocmd FileType python :iabbrev <buffer> iff if():<left><left>
        autocmd FileType python map <buffer> <F5> :w<CR>:FloatermNew --autoclose=0 python3 "%"<CR>
        autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:FloatermNew --autoclose=0 python3 "%"<CR>
augroup END


local M = {}

M.general = {
  i = {
    ["jj"] = { "<esc>", "Quick escape to normal mode"},
-- Easy insertion of a trailing ':', ';' or ',' from insert mode
    [":::"] = { "<esc>A:<esc>", "Easy insertion of a trailng :"},
    [";;"] = { "<esc>A;<esc>", "Easy insertion of a trailng ;"},
    [",,"] = { "<esc>A,<esc>", "Easy insertion of a trailng ,"},
-- Wr:wrapline and run the current file in python
    ["<F5>"] = {
        "<ESC>:w<CR><cmd>lua require('nvterm.terminal').send('python3 ' .. vim.fn.expand('%'), 'float')<CR>",
        "Run file in Python",
    },
  },
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
-- Edit nvim configuration file
    ["<leader>ve"] = { ":edit ~/.config/nvim/lua/custom/chadrc.lua<CR>", "Edit chadrc.lua file"},
-- Source nvim configuration file to reflect changes
-- Allow gf to open non-existent files
    ["<leader>gf"] = { ":edit <cfile><CR>", "Open a file, even if it's new"},
-- Remove highliting
    ["<leader>k"] = { ":nohlsearch<CR>", "Clear highlights"},
    -- ["<Esc>"] = { ":noh <CR>", "clear highlights" }, -- Default to clear highlights
-- Comenta palavra com Aspas
    ["<leader>\""] = { "viw<esc>a\"<esc>bi\"<esc>lel", "Comment word with brackets"},
-- Comenta palavra com Plicas
    ["<leader>\'"] = { "viw<esc>a\'<esc>bi\'<esc>lel", "Comment word with Plicas"},
-- Remove trailing White Spaces
    ["<leader>sws"] = { ":%s/\\s\\+$//<CR>", "Close a buffer"},
-- Doesn't work well in this type of configuration
    -- ["<leader>vr"] = { ":source ~/.config/nvim/init.lua<CR>", "Reload init.lua to reflect changes"},
-- Close a buffer
    -- ["<leader>Q"] = { ":bufdo bdelete<CR>", "Close a buffer"},
    -- ["<leader>x"] = { ":bufdo bdelete<CR>", "Close a buffer"}, -- This is the Default
-- Make Y behave like the other capitals
    ["Y"] = { "y$", "Yank until the end of the line"},
-- Delete character but don't put it in the clipboard
    -- ["x"] = { "_x", "Delete character but don't put it in the clipboard"},
-- Keep it centered
    -- ["n"] = { "nzzzv", "keep it centered"},
    -- ["N"] = { "Nzzzv", "keep it centered"},
    -- ["J"] = { "mzJ`z", "keep it centered"},
-- Write and run the current file in python
    -- ["<F5>"] = {
    --     --require("nvterm.terminal").toggle('float').send("python3 " .. vim.fn.expand('%')),
    --     "<ESC>:w<CR><cmd>lua require('nvterm.terminal').send('python3 ' .. vim.fn.expand('%'), 'float')<CR>",
    --     --require("nvterm.terminal").send("python3 " .. vim.fn.expand('%')),
    --     "Run file in Python",
    -- },
--    ["<F5>"] = {
--            require("vim-floaterm"),
--            print("floaterm used")
--
--        },
  },
  v = {
    ["<"] = { "<gv", "Indent and Maintain selection"},
    [">"] = { ">gv", "Indent and Maintain selection"},
-- Reselect visual selection after indenting
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
    ["y"] = { "myy`y", "Yank and keep position"},
    ["Y"] = { "myY`y", "Yank and keep position"},
-- " Comenta seleção com Aspas
    ["<leader>\""] = { ":normal! `>a\"<esc>`<i\"<esc>`>el", "Comment word with brackets"},
-- " Comenta seleção com Plicas
    ["<leader>\'"] = { ":normal! `>a'<esc>`<i'<esc>`>el", "Comment word with Plicas"},
-- 
--    ["<leader>\'"] = { ":normal! `>a'<esc>`<i'<esc>`>el", "Comment word with Plicas"},
  }
}

-- more keybinds!
local pygroup = vim.api.nvim_create_augroup("PythonOnly", {clear = true})
vim.api.nvim_create_autocmd("FileType",  {pattern = "*.py", command = vim.cmd(":nnoremap <buffer> <leader>cc mm}k^m1{j<C-v>'1:normal! I#<esc>'ml"), group = pygroup})
vim.api.nvim_create_autocmd("FileType",  {pattern = "*.py", command = vim.cmd(":nnoremap <buffer> <leader>c mm}k^m1{j<C-v>'1:normal! I#<esc>'ml"), group = pygroup})
vim.api.nvim_create_autocmd("FileType",  {pattern = "*.py", command = vim.cmd(":map <buffer> <F5> :w<CR>:FloatermNew --autoclose=0 python3 '%'<CR>"), group = pygroup})
vim.api.nvim_create_autocmd("FileType",  {pattern = "*.py", command = vim.cmd(":imap <buffer> <F5> <esc>:w<CR>:FloatermNew --autoclose=0 python3 '%'<CR>"), group = pygroup})
-- vim.api.nvim_create_autocmd("FileType",  {pattern = "*.py", callback = function()
--     require('voldikss/vim-floaterm')
--     vim.cmd(":imap <buffer> <F5> <esc>:w<CR>:FloatermNew --autoclose=0 python3 '%'<CR>")
-- end, group = pygroup})
-- " PYTHON SPECIFIC
-- augroup filetype_python
--         " Comenta Paragrafo ou bloco de codigo com #
--         autocmd FileType python nnoremap <buffer> <leader>cc mm}k^m1{j<C-v>'1:normal! I#<esc>`ml
--
--         " Atalho para comentar uma linha em pyton
--         autocmd FileType python nnoremap <buffer> <leader>c I#<esc>
--
--         " Não quero o wrapline na edição de ficheiros python
-- "        autocmd BufNewFile,BufRead *.py setlocal nowrap
-- "        autocmd FileType python :iabbrev <buffer> iff if():<left><left>
--         autocmd FileType python map <buffer> <F5> :w<CR>:FloatermNew --autoclose=0 python3 "%"<CR>
--         autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:FloatermNew --autoclose=0 python3 "%"<CR>
-- augroup END
--

return M


-- " When text is wrapped, move by terminal rows, not lines, unless a count is provided
-- noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
-- noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
--
-- " Open the current file in the default program
-- nmap <leader>x :!xdg-open %<cr><cr>
--
-- nnoremap <C-Tab> :bnext<cr>
-- nnoremap <C-S-Tab> :bprevious<cr>
--
--
-- " Shift-Tab in visual mode to number lines...
-- xnoremap <S-TAB> :s/\%V/0<C-V><TAB>/<CR>gvg<C-A>gv:retab<ESC>gvI<C-G>u<ESC>gv/ <CR>:s/\%V /./<CR>
--
-- " Go to buffer by number
-- noremap <leader>1 :b1<cr>
-- noremap <leader>2 :b2<cr>
-- noremap <leader>3 :b3<cr>
-- noremap <leader>4 :b4<cr>
-- noremap <leader>5 :b5<cr>
-- noremap <leader>6 :b6<cr>
-- noremap <leader>7 :b7<cr>
-- noremap <leader>8 :b8<cr>
-- noremap <leader>9 :b9<cr>
-- noremap <leader>0 :blast<cr>
-- noremap <leader>+ :bnext<cr>
-- noremap <leader>- :bprevious<cr>
-- "noremap <leader>+ <Plug>AirlineSelectNextTab
-- "noremap <leader>- <Plug>AirlineSelectPrevTab
-- "
-- "keymaps for tabs (not buffers)
-- "noremap <leader>tn :tabnew<CR>
-- "noremap <leader>tx :tabclose<CR>
-- "noremap <leader>+ :tabn<CR>
-- "noremap <leader>- :tabp<CR>
--
-- "Clipboard
-- " Copy to clipboard
-- vnoremap  <leader>y  "+yy
-- nnoremap  <leader>Y  "+yg_
-- "nnoremap  <leader>y  "+yy
-- nnoremap  <leader>yy  "+yy
--
-- " Paste from clipboard
-- nnoremap <leader>p "+p
-- nnoremap <leader>P "+P
-- vnoremap <leader>p "+p
-- vnoremap <leader>P "+P
--
--

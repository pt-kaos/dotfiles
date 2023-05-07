local opt = vim.opt
local g = vim.g
local api = vim.api

g.mapleader = "\\"
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.title = true
opt.list = true
opt.listchars = "tab:▸\\ ,trail:·"
opt.scrolloff = 8
opt.sidescrolloff = 8


-- " To have Vim jump to the last position when reopening a file
api.nvim_create_autocmd(
    "BufReadPost",
    { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)


-- opt.wildmode=longest:full,full	"Show list and iterate full completions
-- opt.infercase			        "Adjust completions to match case
-- opt.completeopt=menu,menuone,noselect

-- opt.expandtab = true -- Default
-- opt.ignorecase = true -- Default
-- opt.smartcase = true -- Default
-- opt.number = true -- Default
-- opt.termguicolors = true -- Default
-- opt.mouse = "a" -- Default
-- opt.splitbelow = true -- Default
-- opt.backspace=indent,eol,start -- Default Behaviour

-- "--------------------------------------------------------------------------
-- " General settings From previous NVIM config
-- "--------------------------------------------------------------------------
-- "opt.hidden -- Default
-- "opt.spell
-- "opt.nowrap
-- "opt.nojoinspaces
-- "opt.splitright
-- "opt.confirm
-- "opt.exrc
-- "opt.backup
-- "opt.backupdir=~/.local/share/nvim/backup//
-- "opt.updatetime=300 " Reduce time for highlighting other references
-- "opt.redrawtime=10000 " Allow more time for loading syntax on large files
--
-- "--------------------------------------------------------------------------
-- " Miscellaneous
-- "--------------------------------------------------------------------------
--
-- highlight Comment term=bold cterm=italic ctermfg=white gui=italic guifg=white
--
-- autocmd TermOpen * startinsert

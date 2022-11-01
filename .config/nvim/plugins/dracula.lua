local cs_status, _ = pcall(vim.cmd, "colorscheme dracula")
if not cs_status then return end

local cmd = vim.cmd

cmd [[
    augroup DraculaOverrides
        autocmd!
        autocmd ColorScheme dracula highlight DraculaBoundary guibg=none
        autocmd ColorScheme dracula highlight DraculaDiffDelete ctermbg=none guibg=none
        autocmd ColorScheme dracula highlight DraculaComment cterm=italic gui=italic
    augroup end
]]
--    "    autocmd User PlugLoaded ++nested colorscheme dracula

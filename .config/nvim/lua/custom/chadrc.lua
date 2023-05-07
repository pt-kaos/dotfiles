---@type ChadrcConfig 
 local M = {}
 M.ui = {theme = 'onedark'}
 M.plugins = "custom.plugins" -- Editar o ficheiro custom/plugins.lua -> ver a documentação nvchad.com/docs/config/plugins
 M.mappings = require "custom.mappings" -- Editar o ficheiro custom/plugins.lua -> ver a documentação nvchad.com/docs/config/plugins
 return M

-- ./mappings.lua
-- ./init.lua
-- ./plugins.lua
-- ./configs/lspconfig.lua

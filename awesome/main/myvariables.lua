awful = require 'awful'
-- local utils = require("utils")

-- modkey or mod4 = super key
modkey = 'Mod4'
altkey = 'Mod1'
modkey1 = 'Control'

-- personal variables
--change these variables if you want
browser1 = 'firefox'
browser2 = 'brave'
browser3 = 'chromium -no-default-browser-check'
editor = os.getenv 'EDITOR' or 'nvim'
editorgui = 'subl'
filemanager = 'thunar'
mailclient = 'thunderbird'
mediaplayer = 'spotify'
terminal = 'alacritty'
virtualmachine = 'virt-manager'
pwmanager = 'keepassxc'

-- awesome variables
awful.util.terminal = terminal
awful.util.tagnames = { '', '', '', '', '', '', '🕸', '🗒', ' ' }
-- 🎶' }
--awful.util.tagnames = {  "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒" }
--awful.util.tagnames = { "⠐", "⠡", "⠲", "⠵", "⠻", "⠿" }
--awful.util.tagnames = { "⌘", "♐", "⌥", "ℵ" }
--awful.util.tagnames = { "www", "edit", "gimp", "inkscape", "music", "🕒", "🗝" "" }
-- Use this : https://fontawesome.com/cheatsheet
--awful.util.tagnames = { "", "", "", "", "" }
-- intersting icons: ⌨  🔆 🎙️🚫
-- awful.layout.suit.tile.left.mirror = true

awful.layout.layouts = {
    awful.layout.suit.tile, -- 1:
    awful.layout.suit.floating, -- 2:
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max, -- 3:
    awful.layout.suit.max.fullscreen, -- 4:
    awful.layout.suit.magnifier, -- 5:
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade,
    --lain.layout.cascade.tile,
    --lain.layout.centerwork,
    --lain.layout.centerwork.horizontal,
    --lain.layout.termfair,
    --lain.layout.termfair.center,
}

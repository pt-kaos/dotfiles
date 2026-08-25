--[[

     Awesome WM configuration template
     https://github.com/awesomeWM

     Freedesktop : https://github.com/lcpz/awesome-freedesktop

     Copycats themes : https://github.com/lcpz/awesome-copycats

     lain : https://github.com/lcpz/lain

--]]

--
-- TODO -> Systray o wrapper widget aparece no segundo ecrã!!!!
--

-- {{{ Required libraries
require("main.myvariables")
-- Standard awesome library
local gears         = require("gears")            --Utilities such as color parsing and objects
local awful         = require("awful")            --Everything related to window managment
                      require("awful.autofocus")
beautiful           = require("beautiful")        -- Theme handling library
local naughty       = require("naughty")          -- Notification library
local freedesktop   = require("freedesktop")

naughty.config.defaults['icon_size'] = 100

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")
dpi                 = require("beautiful.xresources").apply_dpi

local my_table      = gears.table
-- }}}

-- {{{ My Configuration files
-- @21-01-2024 - REMOVI O "local keys =", "local utils = " e o "local rules = "
--local keys = require("keys")
require("keys")
require("utils")
require("main.rules")
-- }}}

require("main.error-handling")

-- {{{ Autostart windowless processes
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        --awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
        awful.spawn(string.format("bash -c \"pgrep -u $USER -fx '%s' > /dev/null || (%s)\"", cmd, cmd))
    end
end

run_once({ "unclutter -root" }) -- entries must be comma-separated
-- }}}

-- {{{ Variable definitions
-- keep themes in alfabetical order for ATT
local themes = {
    "blackburn",		-- 1
    "copland",      	-- 2
    "multicolor",	 	-- 3
    "powerarrow",		-- 4
    "powerarrow-blue",  -- 5
    "powerarrow-dark",  -- 6
    "kaos",             -- 7
}

-- choose your theme here
local chosen_theme = themes[7]

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)

--require("signals")
require("themes.widgets")
-- }}}

-- {{{ Menu
local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "Screen Resolution", "arandr" },
    { "Oeiras", "autorandr.sh" },
    { "Cabril", "cabril.sh" },
}

awful.util.mymainmenu = freedesktop.menu.build({
    before = {
        { "Awesome", myawesomemenu },
        -- { "Atom as an example", atom-as-an-example-or-function },
        -- other triads can be put here
    },
    after = {
        { "Terminal", terminal },
        { "Log out", function() awesome.quit() end },
        { "Sleep", "systemctl suspend" },
        { "Restart", "systemctl reboot" },
        { "Shutdown", "systemctl poweroff" },
        -- other triads can be put here
    }
})

-- {{{ Mouse bindings
root.buttons(my_table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
--
-- if true, the mouse movement focuses the window 
awful.mouse.snap.client_enabled = false
-- }}}

require("main.signals")

-- Autostart applications
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
awful.spawn.with_shell("picom -b --config  $HOME/.config/awesome/picom.conf")



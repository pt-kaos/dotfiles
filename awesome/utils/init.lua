local awful     = require("awful") --Everything related to window managment
local beautiful = require("beautiful")

dmenu_run_f = function ()
    --awful.spawn(string.format("dmenu_run -i -nb '#191919' -nf '#fea63c' -sb '#fea63c' -sf '#191919' -fn NotoMonoRegular:bold:pixelsize=14",
    awful.spawn(string.format("dmenu_run -i -nb '#191919' -nf '#feb67c' -sb '#ffb65c' -sf '#191919' -fn Terminus:bold:pixelsize=14",
    beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))
end


local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local shape = require('gears.shape')
local lain  = require('lain')
--local dpi   = require("beautiful.xresources").apply_dpi
--local beautiful = require('beautiful')
local my_table      = gears.table

-- From Files
--local mylayoutbox = require('themes.widgets.layoutbox')
--shapefn = require("themes.widgets.shape_functions")
--local taglist_widget = require("themes.widgets.taglist_widget")
local wrapper = require("themes.widgets.widget_wrapper")
--local date_widget = require("themes.widgets.date")
local time_widget = require("themes.widgets.time")
local cpu = require('themes.widgets.cpu')
local mytextclock = require('themes.widgets.cal')
local mem = require('themes.widgets.mem')
--local temp = require('themes.widgets.temp')
--local disk = require('themes.widgets.disk')
--volume = require('themes.widgets.vol')
beautiful.volume = require('themes.widgets.vol') -- As keys de update do volume invocam o beautiful.valume.update()
local bat = require('themes.widgets.bat')
--local bat = require('themes.widgets.battery')
--local media = require('themes.widgets.media')
--local kblayout = require('themes.widgets.kblayout')

--local ram = require("themes.awm-widgets.ram-widget.ram-widget")

-- Separators
--local space = wibox.widget.textbox(' ')
local space = wibox.widget.textbox('<span>  </span>')
--local seperator = wibox.widget.textbox(string.format(' <span color="%s">|</span>  ', theme.darkgrey))
--widgets.seperator = wibox.widget.textbox(string.format(' <span color="%s">|</span>  ', beautiful.xcolor8))

local separator = wibox.widget.separator {
    orientation = "vertical",
    color = beautiful.fg_normal .. "70",
    thickness = dpi(2),
    span_ratio = 0.6,
    forced_width = dpi(8)
}

--local is_vertical = false -- monitor has an horizontal layout. Not thinking of having a vertical layout

--local function wrap_widget(widget)
----    local container = wibox.container.background(widget, beautiful.darkgrey, shape.rounded_rect)
--    local container = wibox.container.background()
--    container:set_widget(widget)
--    container:set_bg(beautiful.darkgreen)  -- Red background
--    container:set_fg(beautiful.red)  -- White border color
--    container:set_border_width(10)
--    container:set_border_color(beautiful.red)
--
--    -- Add 0.9 transparency (adjust as needed)
--    container:set_opacity(0.9)
--
--    return container
--end

--local function wrap_widget(widget)
--    local container_margin = wibox.container.margin(widget, 4, 4)  -- Add margin (adjust as needed)
--    container_margin:set_opacity(0.9)
--    --local container_bg = wibox.container.background(container_margin, beautiful.darkgreen .. "90", shapefn.create_partially_rounded_rect(4))
--    local container_bg = wibox.container.background(container_margin, beautiful.darkgreen .. "90", shapefn.create_hexagon(4))
--    container_bg:set_fg(beautiful.darkred)
--    container_bg:set_opacity(0.9)
--    container_bg.border_width = 2
--    container_bg.border_color = beautiful.red
----
----    local container_margin = wibox.container.margin(widget, 4, 4)  -- Add margin (adjust as needed)
----
----    -- Add 0.9 transparency (adjust as needed)
----
--    return container_bg
--end

--local mydock = awful.wibar({
--    position = "bottom",
--    height = 30,
--    type = "dock",
--    screen = 1
--})
--mydock.bg = beautiful.vdark_gray .. "20"

--mydock:setup{
------    {
--        layout = wibox.layout.align.horizontal,
--        {
--            --widget = wrap_widget(wibox.widget {
--            --    text = "GANDA NOIA!!!",
--            --    forced_height = 30,
--            --    align = "left",
--            --    valign = "center",
--            --    widget = wibox.widget.textbox,
--            --}),
--            -- wrapper.wrap_widget(widget, bg, fg, tr, shape, value)
--            --widget = wrap_widget(wibox.widget.textbox("THIS IS A TEST!!"), beautiful.darkgreen, beautiful.red, 1, "hex", 2 ),
--            widget = wrap_widget(wibox.widget.textbox("THIS IS A TEST!!")),
--            align = "left",
--        },
----        wrap_widget(mem.widget),
--        {
------            layout = wibox.layout.align.horizontal,
----            --mylayoutbox(1),
----            widget = wrap_widget(wibox.widget {
----                text = "SEGUNDO!!!",
----                forced_height = 30,
----                align = "left",
----                valign = "center",
----                widget = wibox.widget.textbox,
----            }),
--            widget = wrap_widget(wibox.widget.textbox("THE SECOND MESSAGE!!")),
--            align = "right",
--        },
----    }
--}

awful.util.taglist_buttons = my_table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = my_table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            --c:emit_signal("request::activate", "tasklist", {raise = true})

            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
                c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end),
    awful.button({ }, 3, function ()
        local instance = nil

        return function ()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({theme = {width = dpi(250)}})
            end
        end
    end),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

awful.screen.connect_for_each_screen(function (s)
    --s.quake = lain.util.quake({ app = "urxvt", height = 0.50, argname = "--name %s" })
    --s.quake = lain.util.quake({ app = awful.util.terminal, height = 0.50 })
    s.quake = lain.util.quake({ app = awful.util.terminal })    -- Quake application
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])    -- Tags
    s.mypromptbox = awful.widget.prompt()    -- Create a promptbox for each screen
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
        awful.button({}, 1, function () awful.layout.inc( 1) end),
        awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
        awful.button({}, 3, function () awful.layout.inc(-1) end),
        awful.button({}, 4, function () awful.layout.inc( 1) end),
        awful.button({}, 5, function () awful.layout.inc(-1) end))
    )

            -- wrapper.wrap_widget(widget, bg, fg, tr, shape, value)
    --s.mytaglist = wrap_widget(awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons), beautiful.darkgreen, beautiful.red, 1, "hex", 2)    -- Create a taglist widget
    s.mytaglist = wrapper.wrap_widget(awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons))    -- Create a taglist widget
    s.mytasklist = wrapper.wrap_widget(awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons))    -- Create a tasklist widget


    s.mywibox = awful.wibar({
        type = "dock",
        position = "top",
        screen = s,
        height = dpi(25),
--        bg = beautiful.bg_normal,
--        fg = beautiful.fg_normal
    })    -- Create the wibox
    s.mywibox.bg = beautiful.vdark_gray .. "20"
    -- Add widgets to the wibox
    s.mywibox:setup {
        {
            {
                layout = wibox.layout.align.horizontal,
                expand = "none",
                { -- Left widgets
                    layout = wibox.layout.fixed.horizontal,
--                    mylayoutbox(s),
--                    wibox.widget.separator {
--                        orientation = "vertical",
--                        color = beautiful.fg_normal .. "70",
--                        thickness = dpi(2),
--                        span_ratio = 0.6,
--                        forced_width = dpi(2)
--                    },
                    s.mytaglist,
                    s.mypromptbox,
                    --mpdicon,
                    --beautiful.mpd.widget,
                },
                s.mytasklist, -- Middle widget
                { -- Right widgets
                    layout = wibox.layout.fixed.horizontal,
                    space,
                    --mailicon,
                    --beautiful.mail.widget,
--                    clockicon,
                    mytextclock,
                    separator,
                    time_widget,
                    space,
--                    netdownicon,
--                    netdowninfo,
--                    netupicon,netupinfo
--                    netupinfo.widget,
--                    volicon,
--                    beautiful.volume, -- As keys de update do volume invocam o beautiful.valume.update()
                    wrapper.wrap_widget(beautiful.volume.widget), -- As keys de update do volume invocam o beautiful.valume.update()
                    space,
--                    memicon,
--                     ram(),
                    mem,
                    separator,
--                    cpuicon,
                    cpu,
                    space,
                    --fsicon,
                    --beautiful.fs.widget,
                    --weathericon,
                    --beautiful.weather.widget,
                    --tempicon,
                    --temp.widget,
--                     baticon,
--                    bat(is_vertical),
                    bat,
                    space,
                    wrapper.wrap_widget(wibox.widget.systray()),
                    space,
                    wrapper.wrap_widget(s.mylayoutbox),
                },
            },
            margins = dpi(2),
            widget = wibox.container.margin
        },
        widget = wibox.container.background
    }
end)

    -- Create the bottom wibox
    --s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, border_width = 0, height = dpi(20), bg = theme.bg_normal, fg = theme.fg_normal })

--    -- If wallpaper is a function, call it with the screen
--    local wallpaper = theme.wallpaper
--    if type(wallpaper) == "function" then
--        wallpaper = wallpaper(s)
--    end
--    gears.wallpaper.maximized(wallpaper, s, true)

    -- Add widgets to the bottom wibox
    --s.mybottomwibox:setup {
    --    layout = wibox.layout.align.horizontal,
    --    { -- Left widgets
    --        layout = wibox.layout.fixed.horizontal,
    --    },
    --    s.mytasklist, -- Middle widget
    --    { -- Right widgets
    --        layout = wibox.layout.fixed.horizontal,
    --        s.mylayoutbox,
    --    },
    --}


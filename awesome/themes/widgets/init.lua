local awful = require 'awful'
local wibox = require 'wibox'
local gears = require 'gears'
local shape = require 'gears.shape'
local lain = require 'lain'
--local dpi   = require("beautiful.xresources").apply_dpi
local my_table = gears.table

-- From Files
beautiful.volume = require 'themes.widgets.vol' -- As keys de update do volume invocam o beautiful.valume.update()
local wrapper = require 'themes.widgets.widget_wrapper'
local time_widget = require 'themes.widgets.time'
local cpu = require 'themes.widgets.cpu'
local mytextclock = require 'themes.widgets.cal'
local mem = require 'themes.widgets.mem'
local bat = require 'themes.widgets.bat'
local space = wibox.widget.textbox '<span>  </span>'

local separator = wibox.widget.separator {
    orientation = 'vertical',
    color = beautiful.fg_normal .. '70',
    thickness = dpi(2),
    span_ratio = 0.6,
    forced_width = dpi(8),
}

awful.util.taglist_buttons = my_table.join(
    awful.button({}, 1, function(t)
        t:view_only()
    end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t)
        awful.tag.viewnext(t.screen)
    end),
    awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
    end)
)

awful.util.tasklist_buttons = my_table.join(
    awful.button({}, 1, function(c)
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
    awful.button({}, 3, function()
        local instance = nil

        return function()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients { theme = { width = dpi(250) } }
            end
        end
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end)
)

awful.screen.connect_for_each_screen(function(s)
    s.quake = lain.util.quake { app = awful.util.terminal } -- Quake application
    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
        awful.button({}, 1, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 2, function()
            awful.layout.set(awful.layout.layouts[1])
        end),
        awful.button({}, 3, function()
            awful.layout.inc(-1)
        end),
        awful.button({}, 4, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 5, function()
            awful.layout.inc(-1)
        end)
    ))

    -- Create a taglist widget
    s.mytaglist = wrapper.wrap_widget(awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons))
    -- Create a tasklist widget
    s.mytasklist = wrapper.wrap_widget(awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons))

    -- Create the wibox
    s.mywibox = awful.wibar {
        type = 'dock',
        position = 'top',
        screen = s,
        height = dpi(25),
    }
    s.mywibox.bg = beautiful.vdark_gray .. '20'
    -- Add widgets to the wibox
    s.mywibox:setup {
        {
            {
                layout = wibox.layout.align.horizontal,
                expand = 'none',
                -- Left widgets
                {
                    layout = wibox.layout.fixed.horizontal,
                    s.mytaglist,
                    s.mypromptbox,
                },
                -- Middle widget
                s.mytasklist,
                -- Right widgets
                {
                    layout = wibox.layout.fixed.horizontal,
                    space,
                    mytextclock,
                    separator,
                    time_widget,
                    space,
                    wrapper.wrap_widget(beautiful.volume.widget), -- As keys de update do volume invocam o beautiful.valume.update()
                    space,
                    mem,
                    separator,
                    cpu,
                    space,
                    bat,
                    space,
                    wrapper.wrap_widget(wibox.widget.systray()),
                    space,
                    wrapper.wrap_widget(s.mylayoutbox),
                },
            },
            margins = dpi(2),
            widget = wibox.container.margin,
        },
        widget = wibox.container.background,
    }
end)

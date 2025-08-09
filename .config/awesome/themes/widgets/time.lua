local awful = require("awful")
local wibox = require("wibox")
local wrapper = require("themes.widgets.widget_wrapper")

local time_widget = wibox.widget {
        awful.widget.watch('bash -c "date \'+%H:%M\'"', 10, function(widget, stdout)
            for line in stdout:gmatch("[^\r\n]+") do
                -- line = string.format("%02d", tonumber(line))
                --widget.font = ('JetBrains Mono Bold Nerd Font Complete 32')
                widget.align = 'center'
                widget.valign = 'center'
                -- widget.forced_width = dpi()
                widget.markup = ('<span font_desc="" color=\'' .. beautiful.orange .. '\'>' .. line .. '</span>')
                return
            end
        end),
        expand = 'outside',
        layout = wibox.layout.align.horizontal
    }

return wrapper.wrap_widget(time_widget)


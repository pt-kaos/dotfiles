local lain = require ("lain")
local wibox = require ("wibox")
local markup = lain.util.markup
local wrapper = require("themes.widgets.widget_wrapper")

local highmem = beautiful.redbrick
local normalmem = beautiful.lightorange

local mem = lain.widget.mem({
    settings = function()
        local usage = mem_now.used
        local usage_str = usage .. "MB "
        local color = normalmem

        if usage > 1000 then
            usage = usage / 1000 
            usage_str = string.format("%.2fGB", usage)
        end
        if mem_now.perc > 80 then
            color = highmem
        end
        widget:set_markup(markup.fontfg(beautiful.font, color, beautiful.widget_mem_text .. usage_str ))
    end
})

return wrapper.wrap_widget(mem.widget)


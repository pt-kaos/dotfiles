local lain = require ("lain")
local markup = lain.util.markup
local wrapper = require("themes.widgets.widget_wrapper")

local max = beautiful.red
local veryhigh = beautiful.lightorange
local high = beautiful.yellow
local med = beautiful.lightgreen
local low = beautiful.darkgreen
local noinfo_color = beautiful.greyblue
local color = low

local cpu = lain.widget.cpu({
    settings = function()
        local perc = cpu_now.usage
        local value = tonumber(perc)

        if perc ~= "N/A" then
            if value >= 90 then
                color = max
            elseif value >= 75 then
                color = veryhigh
            elseif value >= 50 then
                color = high
            elseif value >= 30 then
                color = med
            else
                color = low
            end
        else
            color = noinfo_color
        end


        widget:set_markup(markup.fontfg(beautiful.font, color, beautiful.widget_cpu_text .. cpu_now.usage .. "%"))
        --widget:set_markup(markup.fontfg(beautiful.font, beautiful.darkgreen, beautiful.widget_cpu_text .." " .. cpu_now.usage .. "% "))
--        widget:set_markup(markup.fontfg(theme.font, "#e33a6e", cpu_now.usage .. "% "))
    end
})

return wrapper.wrap_widget(cpu.widget)

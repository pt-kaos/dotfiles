local lain = require ("lain")
local markup = lain.util.markup
local wrapper = require("themes.widgets.widget_wrapper")

-- Battery
local batmax = beautiful.widget_batmax_text
local bathigh = beautiful.widget_bathigh_text
local batlow = beautiful.widget_batlow_text
local batcrit = beautiful.widget_batcrit_text
local baticon = batmax
local max = beautiful.darkgreen
local high = beautiful.lightgreen
local med = beautiful.yellow
local low = beautiful.lightorange
local critical = beautiful.red
local charging = beautiful.darkcyan
local noinfo_color = beautiful.greyblue
local baticon_color = max

local bat = lain.widget.bat({
    settings = function()
        --local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc
        local perc = bat_now.perc
        local value = tonumber(perc)

        if perc ~= "N/A" then
            if value >= 90 then
                baticon_color = max
                baticon = batmax
            elseif value >= 60 then
                baticon_color = high
                baticon = bathigh
            elseif value >= 50 then
                baticon_color = med
                baticon = bathigh
            elseif value >= 30 then
                baticon_color = med
                baticon = batlow
            elseif value >= 15 then
                baticon_color = low
                baticon = batlow
            else
                baticon_color = critical
                baticon = batcrit
            end
        else
            baticon = ""
            baticon_color = noinfo_color
        end

        perc = perc .. "%"

        if bat_now.ac_status == 1 then
            perc = perc .. beautiful.widget_power2_text
            baticon_color = charging
        end

        -- widget:set_markup(markup(baticon_color, baticon) .. " " .. markup.fontfg(beautiful.font, baticon_color, perc .. " "))
        widget:set_markup(markup(baticon_color, baticon) .. " " .. markup.fontfg(beautiful.font, baticon_color, perc))
    end
})

return wrapper.wrap_widget(bat.widget)

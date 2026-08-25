local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local shape = require("gears.shape")
local shape_fn = require("themes.widgets.shape_functions")

local wrapper = {}

function wrapper.wrap_widget(widget)
    local bg = beautiful.darkgray
    local fg = beautiful.lightgray
    local value = 4
    local container_margin = wibox.container.margin(widget, 4, 4, 2, 2)  -- Add margin (adjust as needed) -> Horizontal Margin

    local container_bg = wibox.container.background(container_margin, bg .. 70, shape_fn.create_partially_rounded_rect(value))
    --container_bg:set_fg(fg)
    --container_bg:set_opacity(tr)
    container_bg.shape_border_width = 1
    container_bg.shape_border_color = fg .. 60
    --container_bg.border_strategy = "inner"

    return container_bg
end

----function wrapper.wrap_widget(widget, bg, fg, tr, shape, value)
--function wrapper.wrap_widget(widget)
--    bg = beautiful.darkgreen
--    fg = beautiful.red
--    tr = 0.9
--    shape = "hex"
--    value = 2
--    local container_margin = wibox.container.margin(widget, 4, 4)  -- Add margin (adjust as needed)
--    if tr ~= nil then
----    -- Add 0.9 transparency (adjust as needed)
--        container_margin:set_opacity(tr)
--    end
--
--    local container_bg = nil
--
--    --local container_bg = wibox.container.background(container_margin, beautiful.darkgreen .. "90", shapefn.create_partially_rounded_rect(4))
--    if shape == "hex" then
--        container_bg = wibox.container.background(container_margin, bg .. tr, shape_fn.create_hexagon(value))
--    elseif shape == "rrect" then
--        container_bg = wibox.container.background(container_margin, bg .. tr, shape_fn.create_rounded_rect(value))
--    elseif shape == "prrect" then
--        container_bg = wibox.container.background(container_margin, bg .. tr, shape_fn.create_partially_rounded_rect(value))
--    elseif shape == "radprog" then
--        container_bg = wibox.container.background(container_margin, bg .. tr, shape_fn.create_radial_progress(value))
--    elseif shape == "powerl" then
--        container_bg = wibox.container.background(container_margin, bg .. tr, shape_fn.create_powerline(value))
--    elseif shape == "recttag" then
--        container_bg = wibox.container.background(container_margin, bg .. tr, shape_fn.create_rectangular_tag(value))
--    elseif shape == "roundbar" then
--        container_bg = wibox.container.background(container_margin, bg .. tr, shape_fn.create_rounded_bar())
--    elseif shape == "hexagon" then
--        container_bg = wibox.container.background(container_margin, bg .. tr, shape_fn.create_hexagon())
--    end
--
--    container_bg:set_fg(fg)
--    container_bg:set_opacity(tr)
--    container_bg.border_width = 2
--    container_bg.border_color = beautiful.red -- Não está a funcionar
--
--    return container_bg
--end

return wrapper

local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local shape = require("gears.shape")

local shape_func = {}

-- Function to create a radial progress shape with a specific percentage
function shape_func.create_radial_progress(percentage)
    return function(cr, width, height)
        shape.radial_progress(cr, width, height, percentage)
    end
end

function shape_func.create_partially_rounded_rect(rate)
    return function(cr, width, height)
        shape.partially_rounded_rect(cr, width, height, true, true, true, true, rate)
    end
end

function shape_func.create_rounded_rect(radius)
    return function(cr, width, height)
        shape.rounded_rect(cr, width, height, radius)
    end
end

function shape_func.create_powerline(arrow_depth)
    return function(cr, width, height)
        shape.powerline(cr, width, height, arrow_depth)
    end
end

function shape_func.create_rounded_bar()
    return function(cr, width, height)
        shape.rounded_bar(cr, width, height)
    end
end

function shape_func.create_hexagon()
    return function(cr, width, height)
        shape.hexagon(cr, width, height)
    end
end

function shape_func.create_rectangular_tag(arrow_len)
    return function(cr, width, height)
        gears.shape.rectangular_tag(cr, width, height, arrow_len)
    end
end

return shape_func

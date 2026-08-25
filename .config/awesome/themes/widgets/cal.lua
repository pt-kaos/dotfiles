local lain = require("lain")
local wibox = require("wibox")
local wrapper = require("themes.widgets.widget_wrapper")
local markup = lain.util.markup

--local clockicon = wibox.widget.textbox(string.format(' <span color="%s">%s </span>', beautiful.blue, beautiful.widget_calendar))
local color = beautiful.blue
mytextclock = wibox.widget.textclock(markup(color, beautiful.widget_cal_text) .. " " .. markup(color, "%d %b"))
--mytextclock = wibox.widget.textclock(markup(color, beautiful.widget_cal_text) .. " " .. markup(color, "%a %d %b ") .. markup(color, "[") .. markup(beautiful.orange, " %H:%M ") .. markup(color, "] "))
mytextclock.font = beautiful.font

-- Calendar
-- local calendaricon = ""
local cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = "Hack 10",
        --fg   = beautiful.fg_normal,
        --bg   = beautiful.bg_normal
        fg   = beautiful.fg_focus,
        bg   = beautiful.bg_focus
    }
})

return wrapper.wrap_widget(mytextclock)


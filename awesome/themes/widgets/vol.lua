local lain = require("lain")
local markup = lain.util.markup
local wrapper = require("themes.widgets.widget_wrapper")

-- ALSA volume

vol = lain.widget.alsa({
	settings = function()
		local volicon = beautiful.widget_volmed_text
		local level = volume_now.level
		if volume_now.status == "off" then
			volume_now.level = volume_now.level .. beautiful.widget_volmute_text
		end
		if level < 15 then
			volicon = beautiful.widget_volmin_text
		elseif level < 70 then
			volicon = beautiful.widget_volmed_text
		else
			volicon = beautiful.widget_volmax_text
		end
		-- Only update the widget if the level is a valid number
		if type(level) == "number" then
			local display_text = volicon .. string.format("%d", level) .. "%"
			widget:set_markup(markup.fontfg(beautiful.font, "#7493d2", display_text))
			--widget:set_markup(markup.fontfg(beautiful.font, "#7493d2", volicon .. volume_now.level .. "% "))
		end
	end,
})

--return wrapper.wrap_widget(vol.widget)
return vol

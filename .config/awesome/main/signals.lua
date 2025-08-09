--local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

-- Reload awesome when a new screen is added or removed
screen.connect_signal("added", function(s)
	awesome.restart()
end)
screen.connect_signal("removed", function(s)
	awesome.restart()
end)

--awful.screen.connect_signal("request::tag_clients", function(s)
--	if s.outputs[1] then
--		awful.spawn.with_shell("autorandr --load dual_mon")
--	else
--		awful.spawn.with_shell("autorandr --load single_mon")
--	end
--end)

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
	awful.spawn.with_shell("nitrogen --restore")
end)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function(s)
	local only_one = #s.tiled_clients == 1
	for _, c in pairs(s.clients) do
		if only_one and not c.floating or c.maximized then
			c.border_width = 2
		else
			c.border_width = beautiful.border_width
		end
	end
end)

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Start the new client as slave.
	-- tenho tido esta função comentada!!!!
	--if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		-- Tenho tido esta função apenas com o 'c' sem o honor_padding
		-- awful.placement.no_offscreen(c)
		awful.placement.no_offscreen(c, { honor_padding = true })
	end
end)

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--   c:emit_signal("request::activate", "mouse_enter", {raise = true})
-- end)

-- Force minimized clients to unminimize.
client.connect_signal("property::minimized", function(c)
	c.minimized = false
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)

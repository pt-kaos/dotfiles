local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

-- ===================================================================
-- -- @ Custom: Robustly handle screen disconnections
--
-- This works by proactively storing the client's last known tag on the
-- client object itself. When a screen is removed, Awesome has already
-- moved the clients from that screen to the first tag of the primary
-- screen by the time the "removed" signal fires.
--
-- By tracking the tag *before* that happens, we can correctly restore
-- the client to its corresponding tag on the primary screen.
-- ===================================================================

-- Store the client's tag whenever it changes. This is our persistent state.
client.connect_signal("property::first_tag", function(c)
    -- Use a custom property on the client object to store its last tag.
    c.last_tag = c.first_tag
end)

-- When a screen is removed, move its clients to the correct tags on the primary screen.
screen.connect_signal("removed", function(s)
    local clients_to_move = {}
    for _, c in ipairs(client.get()) do
        -- The screen property has already been updated by Awesome,
        -- so we check if the client's *last known* screen was the one removed.
        if c.screen == s then
            table.insert(clients_to_move, c)
        end
    end

    -- A minimal delay is still used to ensure this logic runs after
    -- Awesome's initial, disruptive client shuffle is complete.
    gears.timer.start_new(0.01, function()
        local primary_screen = screen.primary
        if not primary_screen then return false end

        for _, c in ipairs(clients_to_move) do
            -- Check if the client is still valid and has our custom property.
            if c.valid and c.last_tag then
                local tag_name = c.last_tag.name
                local new_tag = awful.tag.find_by_name(primary_screen, tag_name)
                if new_tag then
                    c:move_to_tag(new_tag)
                end
            end
        end
        return false -- The timer only needs to run once.
    end)
end)


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
    -- Set the client's initial last_tag property.
    c.last_tag = c.first_tag

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

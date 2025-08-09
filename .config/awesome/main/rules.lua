local gears         = require("gears") --Utilities such as color parsing and objects
local awful         = require("awful") --Everything related to window managment
-- Widget and layout library
local beautiful     = require("beautiful")

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen,
            size_hints_honor = false
        }
    },

    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },
      properties = { titlebars_enabled = false } },     -- TitleBars Disabled -> code removed from the rules
      --
    -- Set applications to always map on the tag X on screen 1.
    { rule = { class = "firefox" },
      properties = { screen = 1, tag = awful.util.tagnames[1], switchtotag = true } },

    { rule = { class = "Brave-browser" },
      properties = { screen = 1, tag = awful.util.tagnames[2], switchtotag = true } },

    { rule = { class = "Subl" },
      properties = { screen = 1, tag = awful.util.tagnames[3], switchtotag = true } },

    { rule = { class = "thunderbird" },
      properties = { screen = 1, tag = awful.util.tagnames[4], switchtotag = true } },

    { rule = { class = "VirtualBox Manager" },
      properties = { screen = 1, tag = awful.util.tagnames[7], switchtotag = true } },

    { rule = { class = "KeePassXC" },
      properties = { screen = 1, tag = awful.util.tagnames[8], switchtotag = true } },

    { rule = { class = "Spotify" },
      properties = { screen = 1, tag = awful.util.tagnames[9], switchtotag = true } },

    { rule = { class = "Subl" },
      properties = { maximized = true } },

    { rule = { class = "Gimp*", role = "gimp-image-window" },
      properties = { maximized = true } },

    { rule = { class = "Gnome-disks" },
      properties = { maximized = true } },

    { rule = { class = "inkscape" },
      properties = { maximized = true } },

    { rule = { class = mediaplayer },
      properties = { maximized = true } },

    { rule = { class = "Vlc" },
      properties = { maximized = true } },

    { rule = { class = "VirtualBox Manager" },
      properties = { maximized = true } },

    { rule = { class = "VirtualBox Machine" },
      properties = { maximized = true } },

    { rule = { class = "Xfce4-settings-manager" },
      properties = { floating = false } },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Arcolinux-welcome-app.py",
          "Blueberry",
          "Blueman-manager",
          "Galculator",
          "Gnome-font-viewer",
          "Gpick",
          "Imagewriter",
          "Font-manager",
          "Kruler",
          "MessageWin",  -- kalarm.
          "archlinux-logout",
          "Peek",
          "Skype",
          "System-config-printer.py",
          "Sxiv",
          "Tor Browser",
          "Unetbootin.elf",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer",
          "Xfce4-terminal"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager", -- Thunderbird's about:config
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
          "Preferences",
          "setup",
        }
      }, properties = { floating = true }
    },

          -- Floating clients but centered in screen
    { rule_any = {
       	class = {
       		"Polkit-gnome-authentication-agent-1",
			"Arcolinux-calamares-tool.py"
		},
	  },
      properties = { floating = true },
	  callback = function (c)
    	awful.placement.centered(c,nil)
      end
    }
}


-- ██╗  ██╗ █████╗  ██████╗ ███████╗ █████╗ ██████╗  ██████╗██╗  ██╗
-- ██║ ██╔╝██╔══██╗██╔═══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██║  ██║
-- █████╔╝ ███████║██║   ██║███████╗███████║██████╔╝██║     ███████║
-- ██╔═██╗ ██╔══██║██║   ██║╚════██║██╔══██║██╔══██╗██║     ██╔══██║
-- ██║  ██╗██║  ██║╚██████╔╝███████║██║  ██║██║  ██║╚██████╗██║  ██║
-- ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝

-- This is Hyprland Lua config file.

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

------------------
---- MONITORS ----
------------------
require 'awesomeconf.monitors'

---------------------
---- MY PROGRAMS ----
---------------------
require 'awesomeconf.myprograms'

-------------------
---- AUTOSTART ----
-------------------
require 'awesomeconf.autostart'

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
require 'awesomeconf.environment'

-----------------------
----- PERMISSIONS -----
-----------------------
require 'awesomeconf.permissions'

-----------------------
---- LOOK AND FEEL ----
-----------------------
require 'awesomeconf.looknfeel'

---------------
---- INPUT ----
---------------
require 'awesomeconf.input'

---------------------
---- KEYBINDINGS ----
---------------------
require 'awesomeconf.keybindings'

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
require 'awesomeconf.windowrules'

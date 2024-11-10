--[[

     KAOS Awesome WM theme 1.0

--]]

local gears = require("gears")
local lain  = require("lain")
local markup = lain.util.markup
local awful = require("awful")
--local wibox = require("wibox")
--local dpi   = require("beautiful.xresources").apply_dpi

local os = os
--local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility


local theme                                     = {}
theme.confdir                                   = os.getenv("HOME") .. "/.config/awesome/themes/kaos"
-- Wallpapers
--theme.wallpaper                                 = theme.confdir .. "/wallpaper.jpg"
--theme.wallpaper                                 = "/usr/share/backgrounds/arcolinux/arco-wallpaper.jpg"
--theme.wallpaper                                 = "/usr/share/archlinux-tweak-tool/data/wallpaper/wallpaper.png"

-- Colors
theme.redbrick                                  = "#ae3e3e"
theme.red                                       = "#af1d18"
theme.lightred                                  = "#ff3438"
theme.orange                                    = "#ff8c00"
theme.lightorange                               = "#f1af5f"
theme.yellow                                    = "#e0da37"
theme.darkcyan                                  = "#3ca4d8"
theme.lightblue                                 = "#5E81AC"
theme.blue                                      = "#7788AF"
theme.grayblue                                  = "#535F7A"
theme.lightgray                                 = "#aaaaaa"
theme.darkgray                                  = "#667070"
theme.lightgreen                                = "#80c090"
theme.green                                     = "#40a060"
theme.darkgreen                                 = "#759575"
theme.vdark_gray                                = "#313131"
theme.black                                     = "#1A1A1A"
theme.light_black                               = "#1c2022"
theme.white                                     = "#F0F0F0"

-- Fonts
-- theme.font                                      = "Terminus 11"
-- theme.taglist_font                              = "Terminus 12"
theme.font                                      = "Hack 11"
theme.taglist_font                              = "Hack 11"
--theme.iconFont                                  = "Font Awesome 5 Free Regular 9"
theme.icon_font_name = "Material Symbols Rounded "
theme.icon_font = theme.icon_font_name .. "16 @FILL=1"

-- Standard Background and Foreground
theme.bg_normal                                 = theme.black
theme.fg_normal                                 = theme.lightgray
theme.bg_focus                                  = theme.vdark_gray
theme.fg_focus                                  = theme.lightblue
theme.bg_urgent                                 = theme.black
theme.fg_urgent                                 = theme.red
theme.fg_minimize                               = theme.darkgray
--theme.fg_minimize                               = theme.white
theme.fg_widget                                 = theme.lightblue
theme.bg_widget                                 = theme.darkgray

-- Borders
theme.border_width                              = dpi(2)
theme.border_normal                             = theme.light_black
theme.border_focus                              = theme.lightred
theme.border_marked                             = theme.darkcyan

-- Menu
theme.menu_bg_normal                            = theme.black
theme.menu_fg_normal                            = theme.lightgray
theme.menu_bg_focus                             = theme.vdark_gray
theme.menu_fg_focus                             = theme.orange
theme.menu_border_width                         = 0
theme.menu_height                               = dpi(25)
theme.menu_width                                = dpi(260)
theme.menu_submenu_icon                         = theme.confdir .. "/icons/submenu.png"
-- theme.menu_bg_normal                            = "#050505dd"
-- theme.menu_bg_focus                             = "#161616dd"

-- Widget Colors
theme.widget_bat_full                           = theme.green
theme.widget_bat_empty                          = theme.red

-- Widget Icons
--theme.widget_calendar                           = ""
theme.widget_cal_text                           = "🗓"
theme.widget_clock_text                         = '🕒'
theme.widget_cpu_text                           = ""
theme.widget_mem_text                           = ''
theme.widget_volmax_text                        = '🔊'
theme.widget_volmed_text                        = '🔉'
theme.widget_volmin_text                        = '🔈'
theme.widget_volmute_text                       = '🔇'
theme.widget_temp_text                          = '🌡'
theme.widget_email_text                         = '✉'  -- '📨'
theme.widget_upl_text                           = '▲'
theme.widget_downl_text                         = '▼'
theme.widget_power1_text                        = '🔌'
theme.widget_power2_text                        = ''
theme.widget_batmax_text                        = ''
theme.widget_bathigh_text                       = ''
theme.widget_batlow_text                        = ''
theme.widget_batcrit_text                       = ''
theme.widget_battery1_text                      = '🔋'
theme.widget_battery2_text                      = '🪫'
theme.widget_battery3_text                      = ''
theme.widget_battery4_text                      = ''
theme.widget_battery5_text                      = ''
theme.widget_battery6_text                      = ''
theme.widget_battery7_text                      = ''
theme.widget_battery8_text                      = ''

theme.widget_brightness_text                    = ''
theme.widget_temp                               = theme.confdir .. "/icons/temp.png"
theme.widget_uptime                             = theme.confdir .. "/icons/ac.png"
theme.widget_cpu                                = theme.confdir .. "/icons/cpu.png"
theme.widget_weather                            = theme.confdir .. "/icons/dish.png"
theme.widget_fs                                 = theme.confdir .. "/icons/fs.png"
theme.widget_mem                                = theme.confdir .. "/icons/mem.png"
theme.widget_note                               = theme.confdir .. "/icons/note.png"
theme.widget_note_on                            = theme.confdir .. "/icons/note_on.png"
theme.widget_netdown                            = theme.confdir .. "/icons/net_down.png"
theme.widget_netup                              = theme.confdir .. "/icons/net_up.png"
theme.widget_mail                               = theme.confdir .. "/icons/mail.png"
theme.widget_batt                               = theme.confdir .. "/icons/bat.png"
theme.widget_clock                              = theme.confdir .. "/icons/clock.png"
theme.widget_vol                                = theme.confdir .. "/icons/spkr.png"

-- Taglist
--theme.taglist_squares_sel                       = theme.confdir .. "/icons/square_a.png"
--theme.taglist_squares_unsel                     = theme.confdir .. "/icons/square_b.png"
theme.taglist_squares_sel                       = theme.confdir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.confdir .. "/icons/square_unsel.png"
theme.taglist_bg_focus                          = theme.bg_normal .. "20"
theme.taglist_fg_focus                          = theme.orange .. "95"
theme.taglist_bg_empty                          = theme.bg_normal .. "20"
theme.taglist_fg_empty                          = theme.lightgray .. "90"
theme.taglist_fg_occupied                       = theme.blue
theme.taglist_bg_occupied                       = theme.bg_normal .. "20"
theme.taglist_bg_urgent                         = theme.bg_urgent
theme.taglist_fg_urgent                         = theme.fg_urgent
theme.taglist_spacing                           = dpi(0)

-- Tasklist
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true

-- Layouts
theme.layout_tile                               = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps                           = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft                           = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.confdir .. "/icons/dwindle.png"
theme.layout_max                                = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.confdir .. "/icons/floating.png"

-- Other settings
theme.useless_gap                               = 5
theme.screen_margin                             = dpi(5)   -- Novo
theme.maximized_hide_border                     = false     -- Novo

--Titlebar
theme.titlebar_close_button_normal              = theme.confdir .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.confdir .. "/icons/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.confdir .. "/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.confdir .. "/icons/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.confdir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.confdir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.confdir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.confdir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.confdir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.confdir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.confdir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.confdir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.confdir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.confdir .. "/icons/titlebar/maximized_focus_active.png"

-- Textclock
os.setlocale(os.getenv("LANG")) -- to localize the clock

return theme

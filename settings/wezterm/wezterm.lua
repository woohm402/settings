local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

-- customization --

local global_font = wezterm.font { family = 'Monaspace Krypton', weight = 'Bold' }

config.initial_cols = 120
config.initial_rows = 28
config.font = global_font
config.font_size = 16
config.color_scheme = 'Dracula'
config.window_background_opacity = 0.95

config.window_frame = {
  font = global_font,
  font_size = 12,
}

config.keys = {
  { key = 'LeftArrow', mods = 'ALT|CMD', action = act.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'ALT|CMD', action = act.ActivateTabRelative(1) },
}

-------------------

return config

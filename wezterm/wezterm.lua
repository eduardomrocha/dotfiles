-- WezTerm
-- https://wezfurlong.org/wezterm/

local wezterm = require("wezterm")

return {
	-- Smart tab bar [distraction free mode]
	hide_tab_bar_if_only_one_tab = true,

	-- Color scheme
	-- https://wezfurlong.org/wezterm/appearance.html
	color_scheme = "Dracula",

	-- window_background_opacity = 0.99,

	-- Font configuration
	-- https://wezfurlong.org/wezterm/config/fonts.html
	font = wezterm.font("FiraCode Nerd Font Mono", { weight = "Medium", stretch = "Normal", style = "Normal" }),
	font_size = 17.0,

	-- Cursor style
	default_cursor_style = "BlinkingUnderline",

	-- Remove Window Padding
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

  mouse_bindings = {
    -- Ctrl-click will open the link under the mouse cursor
    {
      event={Up={streak=1, button="Left"}},
      mods="CTRL",
      action=wezterm.action.OpenLinkAtMouseCursor,
    },
  },
}

-- WezTerm
-- https://wezfurlong.org/wezterm/

local wezterm = require("wezterm")

return {
	default_domain = "WSL:Ubuntu-20.04",
	-- Smart tab bar [distraction free mode]
	hide_tab_bar_if_only_one_tab = true,
	-- Color scheme
	-- https://wezfurlong.org/wezterm/appearance.html
	color_scheme = "Dracula",
	-- Font configuration
	-- https://wezfurlong.org/wezterm/config/fonts.html
	font = wezterm.font("FiraCode Nerd Font Mono", { weight = "Medium", stretch = "Normal", style = "Normal" }),
	font_size = 12.0,
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
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
	keys = {
		{
			key = "c",
			mods = "CTRL",
			action = wezterm.action_callback(function(window, pane)
				local sel = window:get_selection_text_for_pane(pane)
				if not sel or sel == "" then
					window:perform_action(wezterm.action.SendKey({ key = "c", mods = "CTRL" }), pane)
				else
					window:perform_action(wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }), pane)
				end
			end),
		},
		{
			key = "v",
			mods = "CTRL",
			action = wezterm.action.PasteFrom("Clipboard"),
		},
		{
			key = "v",
			mods = "CTRL",
			action = wezterm.action.PasteFrom("PrimarySelection"),
		},
	},
}

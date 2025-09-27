local wezterm = require("wezterm")
local config = wezterm.config_builder()

----------------------------------------------------------------
----------------------------------------------------------------

local is_darwin = function()
	return wezterm.target_triple:find("darwin") ~= nil
end

local is_win = function()
	return wezterm.target_triple:find("windows") ~= nil
end

----------------------------------------------------------------
----------------------------------------------------------------

config.term = "xterm-256color"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.initial_cols = 120
config.initial_rows = 32

config.macos_window_background_blur = 40
config.window_background_opacity = 0.7

config.font = wezterm.font("JetBrainsMonoNL Nerd Font", { weight = "Medium" })
-- config.font = wezterm.font("Maple Mono Normal", { weight = "Medium" })
config.color_scheme = "Arthur (Gogh)"
config.line_height = 1

if is_darwin() then
	config.font_size = 13.0
	config.native_macos_fullscreen_mode = true

	wezterm.on("gui-startup", function(cmd)
		local _, _, window = wezterm.mux.spawn_window(cmd or {})
		window:gui_window():toggle_fullscreen()
	end)
end

if is_win() then
	config.font_size = 10.0
	config.line_height = 1
	config.default_prog = { "pwsh", "--nologo" }
	config.window_decorations = "RESIZE"
end

config.adjust_window_size_when_changing_font_size = false
config.window_padding = {
	left = 4,
	right = 0,
	top = 4,
	bottom = 0,
}
config.window_frame = {
	border_left_color = "black",
	border_right_color = "black",
	border_bottom_color = "black",
	border_top_color = "black",
}

return config

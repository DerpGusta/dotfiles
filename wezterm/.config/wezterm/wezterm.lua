-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
local function colorscheme()
  local home = os.getenv("HOME")
  local file = io.open(home .. "/.cache/wal/last_used_theme", "r")

  if not file then
    return "Catppuccin Mocha"
  else
    local line = file:read("*l")
    -- Find the position of the first period and substring up to the period if it exists
    line = string.sub(line, 1, string.find(line, "%.") - 1 or #line + 1)
    if line == "gruvbox-light" then
      return "Gruvbox Light"
    elseif line == "gruvbox-dark" then
      return "Gruvbox dark, hard (base16)"
      -- return "Builtin Solarized Dark"
    end
  end
end
config.color_scheme = colorscheme()
config.font = wezterm.font_with_fallback({ "JetBrainsMono NF", "Symbols Nerd Font Mono"})
config.font_size = 10
config.line_height = 1.0
-- config.cell_width = 1.0
config.hide_tab_bar_if_only_one_tab = true
config.warn_about_missing_glyphs = true
config.window_padding = {
  left = 1,
  right = 0,
  bottom = 0,
}
-- and finally, return the configuration to wezterm
return config


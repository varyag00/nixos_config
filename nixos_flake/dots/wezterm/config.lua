-- Pull in the wezterm API and config
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- helper functions
local function get_hostname()
	local f = io.popen("hostname")
	local hostname = f:read("*a") or ""
	f:close()
	hostname = string.gsub(hostname, "\n$", "")
	return hostname
end

local function is_weekend()
	local day_of_week = os.date("%A")
	return day_of_week == "Friday" or day_of_week == "Saturday" or day_of_week == "Sunday"
end

-- if this looks weird, try the official "Catppuccin Macchiato"
config.color_scheme = "catppuccin-macchiato"
-- config.color_scheme = "Catppuccin Macchiato"

-- SECTION: font

-- ligatures: --> != ~~>
-- -- all off
-- harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
--  -- all on
-- harfbuzz_features = { "calt=1", "clig=1", "liga=1" },

local function font_with_fallback(font_family)
	-- family names, not file names
	return wezterm.font_with_fallback({
		font_family,
		-- "font awesome 6 free solid", -- nice double-spaced symbols!
	})
end
local function font_and_rules_iosevka()
	-- local font_name = "Iosevka Nerd Font"
	-- local font_name = "Iosevka Nerd Font Mono"
	-- local font_name = "Iosevka Nerd Font Propo"
	-- local font_name = "IosevkaTerm Nerd Font"
	-- local font_name = "IosevkaTerm Nerd Font Propo"

	-- -- only option with MONOspace symbols
	local font_name = "IosevkaTerm Nerd Font Mono" -- NOTE: current fav
	-- use a _very slightly_ lighter variant, so that regular bold really stand out
	local font = font_with_fallback({ family = font_name, weight = "DemiLight" })
	local font_rules = {
		-- font weight options: https://wezfurlong.org/wezterm/config/lua/wezterm/font.html
		-- font_rules: https://wezfurlong.org/wezterm/config/lua/config/font_rules.html?h=font_rule

		-- bold and not-italic
		{
			intensity = "Bold",
			italic = false,
			font = font_with_fallback({ family = font_name, weight = "Bold" }),
		},
		-- bold and italic
		{
			intensity = "Bold",
			italic = true,
			font = font_with_fallback({ family = font_name, italic = true, weight = "Bold" }),
		},
		-- normal and not-italic
		{
			intensity = "Normal",
			italic = false,
			font = font_with_fallback({ family = font_name, italic = false, weight = "DemiLight" }),
		},
		-- normal and italic
		{
			intensity = "Normal",
			italic = true,
			font = font_with_fallback({ family = font_name, italic = true, weight = "Medium" }),
		},
		-- half-intensity and italic
		{
			intensity = "Half",
			italic = true,
			font = font_with_fallback({ family = font_name, italic = true, weight = "ExtraLight" }),
		},
	}

	config.font = font
	config.font_rules = font_rules
	config.font_size = 13
end

local function font_and_rules_scp()
	config.font = font_with_fallback({ family = "SauceCodePro Nerd Font Mono" })
	config.font_size = 13
	-- config.font_rules = {}
end

local function font_and_rules_pixel()
	config.font = font_with_fallback({ family = "Monocraft Nerd Font" })
	-- like Monocraft, but a little more readable
	-- config.font = font_with_fallback({ family = "Miracode" })
	config.font_size = 12
	-- config.font_rules = {}
end

local function font_and_rules_jetbrains()
	config.font = font_with_fallback({ family = "JetBrainsMono Nerd Font" })
	config.font_size = 13
	-- config.font_rules = {}
end

local machine_name = os.getenv("MACHINE_NAME") or get_hostname()

if machine_name == "SE-K7N2N4QLGP" then
	-- fun friday font
	if is_weekend() then
		font_and_rules_pixel()
	else
		font_and_rules_scp()
	end
elseif machine_name == "dan-pop" then
	font_and_rules_iosevka()
else
	-- default font
	font_and_rules_scp()
	-- font_and_rules_jetbrains()
end

-- END_SECTION: Font

-- SECTION: QoL Fixes ----

-- NOTE: I die a little every time I hear this bell sound
config.audible_bell = "Disabled"

-- performance tweaks
config.front_end = "WebGpu"
config.max_fps = 120
config.animation_fps = 120

-- <C-T> = new tab
config.hide_tab_bar_if_only_one_tab = true

-- Standardize on CarriageReturn on all systems; No more ^M symbols!
config.canonicalize_pasted_newlines = "CarriageReturn"

config.skip_close_confirmation_for_processes_named = {
	"bash",
	"sh",
	"zsh",
	"fish",
	"tmux",
	"nu",
	"cmd.exe",
	"pwsh.exe",
	"powershell.exe",
}
-- END_SECTION: QoL Fixes ----

-- SECTION: Keybindings
config.mouse_bindings = {
	-- C-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

-- Declare before modifying below
config.keys = {
	{
		key = "l",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.ShowLauncher,
	},
	{
		key = "V",
		mods = "CTRL",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
}

config.launch_menu = {
	{
		args = { "top" },
	},
	{
		-- Optional label to show in the launcher. If omitted, a label
		-- is derived from the `args`
		label = "WSL",
		-- The argument array to spawn.  If omitted the default program
		-- will be used as described in the documentation above
		args = { "wsl.exe", "~" },
	},
}
-- END_SECTION: Keybindings

-- NOTE: I put profile/OS-level config here because wezterm struggles with at loading
-- modules outside of { ~/.wezterm,  ~/.config/wezterm}
-- https://wezfurlong.org/wezterm/config/files.html?h=module#making-your-own-lua-modules
-- E.g. require("profiles") does not pick up ./profiles.lua, probably when using using
-- $WEZTERM_CONFIG_FILE
-- E.g. this doesn't work either even though the path is correct, possible because due
-- to permissions?
-- local profiles = require(wezterm.config_dir .. "\\profiles.lua")
local profiles = {}

function profiles.apply_windows_config(config)
	-- see: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
	config.wsl_domains = {
		{
			name = "dan@WSL:Ubuntu",
			distribution = "Ubuntu-22.04",
			default_cwd = "~/",
			-- default_prog = { "zsh" },
		},
	}
	-- see: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
	config.ssh_domains = {}
	-- see: https://wezfurlong.org/wezterm/shell-integration.html?h=shell#using-clink-on-windows-systems
	config.set_environment_variables = {}

	if wezterm.target_triple == "x86_64-pc-windows-msvc" then
		-- Use OSC 7 as per the above example
		config.set_environment_variables["prompt"] =
			"$E]7;file://localhost/$P$E\\$E[32m$T$E[0m $E[35m$P$E[36m$_$G$E[0m "
		-- use a more ls-like output format for dir
		config.set_environment_variables["DIRCMD"] = "/d"
		-- NOTE: use cmder as cmd.exe (requires %cmder_root% env var set globally)
		config.default_prog = { "cmd.exe", "/s", "/k", "%cmder_root%/vendor/init.bat" }
	end

	local added_keys = {
		-- NOTE: replaced by ShowLauncher above
		-- Create a tab in a named domain
		-- {
		-- 	key = "L",
		-- 	mods = "CTRL|ALT|SHIFT",
		-- 	action = wezterm.action.SpawnTab({
		-- 		DomainName = "dan@WSL:Ubuntu",
		-- 	}),
		-- },
	}

	for i, key in ipairs(added_keys) do
		table.insert(config.keys, key)
	end
end

function profiles.apply_linux_config(config)
	config.ssh_domains = {}
	config.set_environment_variables = {}
end

if os.getenv("OS") == "Windows_NT" then
	profiles.apply_windows_config(config)
-- TODO: conditions for Darwin and Linux
else
	profiles.apply_linux_config(config)
end

return config

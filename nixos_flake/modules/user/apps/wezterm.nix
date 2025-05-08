{
  lib,
  pkgs,
  flakeVars,
  shellVars,
  ...
}:
let
  # dots_repo = builtins.fetchGit {
  #   url = "https://github.com/varyag00/dots";
  #   ref = "main";
  #   rev = "4c435a76438c97b12e1ea646e07a51c043750014";
  # };
  # wezterm_dots = builtins.readFile (builtins.toPath "${dots_repo}/dot_config/wezterm/wezterm.lua");

  wezterm_config_dir = "${shellVars.XDG_CONFIG_HOME}/wezterm";
  wezterm_config_file = "${shellVars.XDG_CONFIG_HOME}/wezterm/config.lua";
in
if flakeVars.system.isLinux then
  {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      # extraConfig = wezterm_dots;
      extraConfig = # lua
        ''
          -- load the entire config from my (symlinked) config.lua, 
          -- allowing on-the-fly editing
          local config = require("config")
          local wezterm = require("wezterm")

          wezterm.config = config
          return wezterm.config
        '';
    };
    home.activation.weztermConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      rm -rf ${wezterm_config_file}
      ln -sf ${flakeVars.FLAKE_DOTS}/wezterm/config.lua ${wezterm_config_file}
    '';

    # programs.zsh.sessionVariables.WEZTERM_CONFIG_FILE = "${wezterm_config_file}";
    # home.sessionVariables.WEZTERM_CONFIG_FILE = "${wezterm_config_file}";
  }
else if flakeVars.system.isDarwin then
  {
    programs.wezterm = {
      enable = true;
      # TEST: disabling this to test for speedup
      # | https://discourse.nixos.org/t/terminal-zsh-performance-issue-under-home-manager-help/55798/10
      enableZshIntegration = false;
      # extraConfig = wezterm_dots;
      extraConfig = # lua
        ''
          -- load the entire config from my (symlinked) config.lua, 
          -- allowing on-the-fly editing
          local config = require("config")
          local wezterm = require("wezterm")

          wezterm.config = config
          return wezterm.config
        '';
    };
    home.activation.weztermConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      rm -rf ${wezterm_config_file}
      ln -sf ${flakeVars.FLAKE_DOTS}/wezterm/config.lua ${wezterm_config_file}
    '';

    # programs.zsh.sessionVariables.WEZTERM_CONFIG_FILE = "${wezterm_config_file}";
    # home.sessionVariables.WEZTERM_CONFIG_FILE = "${wezterm_config_file}";
  }
else
  { }

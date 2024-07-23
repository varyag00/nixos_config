{ pkgs, ... }: 
let
  dots_repo = builtins.fetchGit {
    url = "https://github.com/varyag00/dots";
    ref = "main";
    rev = "4c435a76438c97b12e1ea646e07a51c043750014";
  };
  wezterm_dots = builtins.readFile (builtins.toPath "${dots_repo}/dot_config/wezterm/wezterm.lua");
in
  {
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = wezterm_dots;
  };
}

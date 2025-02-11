{
  lib,
  config,
  pkgs,
  pkgs-hc,
  flakeVars,
  ...
}:

{
  home.packages = [
    pkgs-hc.terraform
    pkgs.vault # TODO: tick this when I have the time
  ];
  programs.zsh.shellAliases = {
    tf = "terraform";
  };
}

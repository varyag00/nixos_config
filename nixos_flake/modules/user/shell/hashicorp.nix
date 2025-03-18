{
  lib,
  config,
  pkgs-hc,
  flakeVars,
  ...
}:

{
  home.packages = [
    pkgs-hc.terraform
    pkgs-hc.tftui
    pkgs-hc.vault
  ];
  programs.zsh.shellAliases = {
    tf = "terraform";
  };
}

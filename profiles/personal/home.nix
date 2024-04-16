{ config, pkgs, userSettings, ... }:

{
  # NOTE: see https://mynixos.com/search?q=home-manager%2Foption for options
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  programs.home-manager.enable = true;
  # home.packages = with pkgs; [
  # git
  # zsh
  # wezterm
  # ];

  imports = [ ../../user/shell/sh.nix ../../user/shell/cli-apps.nix ../../user/packages/lsp.nix 
 # ../../user/packages/nvim.nix
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

}

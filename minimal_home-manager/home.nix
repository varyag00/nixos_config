{ config, pkgs, ... }:

{
  home.username = "dan";
  home.homeDirectory = "/home/dan";

  programs.home-manager.enable = true;

  imports = [
    ../user/shell/sh.nix # shell
    # ../../user/shell/cli-collection.nix # Useful CLI apps
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  # home.packages = with pkgs; [
  # git
  # zsh
  # wezterm
  # ];
}

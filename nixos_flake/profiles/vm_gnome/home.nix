{ config, pkgs, userSettings, ... }:

{
  # NOTE: see https://mynixos.com/search?q=home-manager%2Foption for options
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  programs.home-manager.enable = true;

  #xdg.enable = true;

  imports = [
    ../../modules/user/shell/sh.nix
    ../../modules/user/shell/cli-apps.nix

    #  ../../modules/user/packages/k8s.nix
    ../../modules/user/packages/lsp.nix
    #  ../../modules/user/packages/nvim.nix
    ../../modules/user/packages/wezterm.nix
    ../../modules/user/packages/vivaldi.nix
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

}

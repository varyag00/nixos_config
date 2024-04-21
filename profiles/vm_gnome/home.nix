{ config, pkgs, userSettings, ... }:

{
  # NOTE: see https://mynixos.com/search?q=home-manager%2Foption for options
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  programs.home-manager.enable = true;

  #xdg.enable = true;

  imports = [ 
    ../../user/shell/sh.nix 
    ../../user/shell/cli-apps.nix 
 #  ../../user/shell/k8s.nix
    ../../user/packages/lsp.nix 
 #  ../../user/packages/nvim.nix
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

}

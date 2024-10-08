{ config, pkgs, userSettings, ... }:

{
  # NOTE: see https://mynixos.com/search?q=home-manager%2Foption for options
  home.username = flakeVars.user.name;
  home.homeDirectory = "/home/" + flakeVars.user.name;

  programs.home-manager.enable = true;

  imports = [ 
    ../modules/sh.nix 
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

}

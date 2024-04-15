{ config, pkgs, userSettings, ... }:

{
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  programs.home-manager.enable = true;
  # home.packages = with pkgs; [
  # git
  # zsh
  # wezterm
  # ];

  imports = [
    ../../user/shell/sh.nix # shell
    # ../../user/shell/cli-collection.nix # Useful CLI apps
    "${fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master"}/modules/vscode-server/home.nix"
  ];
  services.vscode-server.enable = true;

  home.stateVersion = "23.11"; # Please read the comment before changing.

}

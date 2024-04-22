{ config, pkgs, ... }:

{
  home.username = "dan";
  home.homeDirectory = "/home/dan";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [ bat dog zoxide lsd bottom fd bc direnv nix-direnv atuin fzf ];

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
  };

  home.stateVersion = "23.11"; # Please read the comment before changing.

  # home.packages = with pkgs; [
  # git
  # zsh
  # wezterm
  # ];
}

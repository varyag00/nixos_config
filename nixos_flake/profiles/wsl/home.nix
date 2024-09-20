{
  config,
  pkgs,
  pkgs-unstable,
  userSettings,
  ...
}:

{
  # NOTE: see https://mynixos.com/search?q=home-manager%2Foption for options
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  programs.home-manager.enable = true;

  imports = [
    ../../modules/user/shell/sh.nix
    ../../modules/user/shell/cli-apps.nix
    ../../modules/user/nvim
    ../../modules/user/features/k8s.nix
    ../../modules/user/features/lsp.nix
    ../../modules/user/features/catppuccin.nix
    # ../../modules/user/features/nix-shells.nix
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.
}

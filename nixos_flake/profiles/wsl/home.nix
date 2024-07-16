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
    #  ../../modules/user/shell/k8s.nix
    ../../modules/user/packages/lsp.nix
    ../../modules/user/packages/nvim.nix
    #  ../../modules/user/packages/python-packages.nix
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.
}

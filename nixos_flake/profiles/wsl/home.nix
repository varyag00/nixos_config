{
  config,
  pkgs,
  pkgs-unstable,
  flakeVars,
  ...
}:

{
  # NOTE: see https://mynixos.com/search?q=home-manager%2Foption for options
  home.username = flakeVars.user.name;
  home.homeDirectory = "/home/" + flakeVars.user.name;

  programs.home-manager.enable = true;

  imports = [
    ../../modules/user/shell
    ../../modules/user/nvim
    ../../modules/user/features/k8s.nix
    ../../modules/user/features/lsp.nix
    ../../modules/user/features/codeium.nix
    ../../modules/user/features/catppuccin.nix
    # ../../modules/user/features/nix-shells.nix
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.
}

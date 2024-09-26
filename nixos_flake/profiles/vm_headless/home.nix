{
  config,
  pkgs,
  flakeVars,
  ...
}:

{
  # NOTE: see https://mynixos.com/search?q=home-manager%2Foption for options
  home.username = flakeVars.user.name;
  home.homeDirectory = "/home/" + flakeVars.user.name;

  programs.home-manager.enable = true;

  imports = [
    ../../user/shell/sh.nix
    ../../user/shell/cli-apps.nix
    #  ../../user/shell/k8s.nix
    ../../user/packages/lsp.nix
    #  ../../user/packages/nvim.nix
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

}

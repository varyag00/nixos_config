{
  config,
  pkgs,
  flakeVars,
  ...
}:

{
  # NOTE: see https://mynixos.com/search?q=home-manager%2Foption for options

  home = {
    username = flakeVars.user.name;
    homeDirectory = "/Users/${flakeVars.user.name}";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;

  imports = [
    "${flakeVars.FLAKE_MODULES}/user/shell"
    "${flakeVars.FLAKE_MODULES}/user/nvim"
    "${flakeVars.FLAKE_MODULES}/user/features/k8s.nix"
    "${flakeVars.FLAKE_MODULES}/user/features/lsp.nix"
    "${flakeVars.FLAKE_MODULES}/user/features/gui.nix"
    "${flakeVars.FLAKE_MODULES}/user/features/catppuccin.nix"
    "${flakeVars.FLAKE_MODULES}/user/features/symlink-dots.nix"
  ];
}

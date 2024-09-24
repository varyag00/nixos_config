{
  config,
  pkgs,
  envVars,
  ...
}:

{
  # NOTE: see https://mynixos.com/search?q=home-manager%2Foption for options

  home = {
    username = envVars.user.name;
    homeDirectory = "/Users/${envVars.user.name}";

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
    "${envVars.FLAKE_MODULES}/user/shell"
    "${envVars.FLAKE_MODULES}/user/nvim"
    "${envVars.FLAKE_MODULES}/user/features/k8s.nix"
    "${envVars.FLAKE_MODULES}/user/features/lsp.nix"
    "${envVars.FLAKE_MODULES}/user/features/gui.nix"
    "${envVars.FLAKE_MODULES}/user/features/catppuccin.nix"

    # TODO: this should not live under shell (maybe?)
    "${envVars.FLAKE_MODULES}/user/shell/work.nix"
    "${envVars.FLAKE_MODULES}/user/shell/mac_core.nix"
    "${envVars.FLAKE_MODULES}/user/shell/mac_dots.nix"
  ];
}

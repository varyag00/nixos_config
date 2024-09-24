{
  config,
  pkgs,
  userSettings,
  ...
}:

{
  # NOTE: see https://mynixos.com/search?q=home-manager%2Foption for options

  home = {
    username = userSettings.username;
    homeDirectory = "/Users/${userSettings.username}";

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
    ../../modules/user/shell
    ../../modules/user/nvim
    ../../modules/user/features/k8s.nix
    ../../modules/user/features/lsp.nix
    ../../modules/user/features/gui.nix
    ../../modules/user/features/catppuccin.nix
  ];

  # home.stateVersion = "23.11"; # Please read the comment before changing.

}

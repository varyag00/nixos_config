{ pkgs, ... }: {
  home.packages = with pkgs;
    [
      neovim
    ];

  programs.neovim = {
    # see options https://mynixos.com/home-manager/options/programs.neovim
    enable = true;
    defaultEditor = true;
  };
}

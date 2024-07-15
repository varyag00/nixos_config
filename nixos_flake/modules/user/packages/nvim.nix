{ config, pkgs, pkgs-unstable, lib, ... }:
{
  home.packages = (with pkgs; [
    # unconfigurated stable packages
  ]) ++ (with pkgs-unstable; [
    # unconfigurated unstable packages
  ]);

  programs.neovim = {
    # Use neovim-unwrapped, see https://stackoverflow.com/a/77460220/1775420
    package = pkgs-unstable.neovim-unwrapped;
    # see options https://mynixos.com/home-manager/options/programs.neovim
    enable = true;
    extraPackages = [
      pkgs.tree-sitter
      pkgs.yaml-language-server
      pkgs.luajitPackages.luarocks-nix
      pkgs.markdownlint-cli
      pkgs.unzip
    ];
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  # create a symlink to nvim binary for vscode-neovim
  home.activation.createNvimVsCodeLink = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p $HOME/.local/bin
    ln -sf ${pkgs-unstable.neovim}/bin/nvim $HOME/.local/bin/nvim_vscode
  '';

  # create a symlink of existing nvim config
  home.file.".config/nvim" = {
    source = ../dots/nvim;
    recursive = true;
  };

  # environment.systemPackages = with pkgs;
  # [
  #   vimPlugins.codeium-vim
  # ];
}

{ config, pkgs, lib, ... }:
{
  programs.neovim = {
    # see options https://mynixos.com/home-manager/options/programs.neovim
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  # create a symlink to nvim binary for vscode-neovim
  home.activation.createNvimVsCodeLink = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p $HOME/.local/bin
    ln -sf ${pkgs.neovim}/bin/nvim $HOME/.local/bin/nvim_vscode
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

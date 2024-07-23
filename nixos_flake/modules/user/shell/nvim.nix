{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
{
  home.packages =
    (with pkgs; [
      # unconfigurated stable packages
      pkgs.lua51Packages.lua
      pkgs.tree-sitter
      pkgs.marksman
    ])
    ++ (with pkgs-unstable; [
      # unconfigurated unstable packages
    ]);

  programs.neovim = {
    # Use neovim-unwrapped, see https://stackoverflow.com/a/77460220/1775420
    package = pkgs-unstable.neovim-unwrapped;
    # see options https://mynixos.com/home-manager/options/programs.neovim
    enable = true;
    extraPackages = [
      # manually install LSP packages instead of using mason-lspconfig
      pkgs.yaml-language-server
      pkgs.luajitPackages.luarocks-nix
      pkgs.markdownlint-cli
      pkgs.unzip
      pkgs.gopls
      pkgs.ruff-lsp
    ];
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  # create a symlink to nvim binary for vscode-neovim
  home.activation.createNvimVsCodeLink = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.local/bin
    ln -sf ${pkgs-unstable.neovim}/bin/nvim $HOME/.local/bin/nvim_vscode
  '';

  # create a symlink to lazyvim config
  home.activation.createNvimConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sf ${../dots/nvim}/dots/nvim $HOME/.config/nvim
  '';

  # environment.systemPackages = with pkgs;
  # [
  #   vimPlugins.codeium-vim
  # ];
}

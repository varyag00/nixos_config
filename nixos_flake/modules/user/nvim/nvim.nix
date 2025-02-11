{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  flakeVars,
  ...
}:
{
  # Required by nvim and other tools
  home.packages = [
    pkgs.tree-sitter
    pkgs.lua51Packages.lua
    pkgs.nodePackages.prettier

    # NOTE: use nix, not mason.nvim, to install LSP packages

    # IDEA: move to lsp.nix?

    # lua
    pkgs.luajitPackages.luarocks-nix
    pkgs.lua-language-server
    pkgs.stylua
    # sh
    pkgs.shellcheck
    pkgs-unstable.bash-language-server
    pkgs-unstable.shfmt
    # yaml
    pkgs.yaml-language-server
    # ansible
    pkgs.ansible-language-server
    # json
    pkgs.vscode-langservers-extracted
    # toml
    pkgs.taplo
    # sql
    pkgs.sqlfluff
    # tf
    pkgs.terraform-ls
    pkgs.tflint
    # helm - active development
    pkgs-unstable.helm-ls

    # NOTE: bigger lsp configs:
    # - ../lang/go
    # - ../lang/python
    # - ../lang/markdown
  ];

  programs.neovim = {
    # Use neovim-unwrapped, see https://stackoverflow.com/a/77460220/1775420
    # FIXME: test if this updates to nvim 0.11.x
    # package = pkgs-unstable.neovim-unwrapped;
    # see options https://mynixos.com/home-manager/options/programs.neovim
    enable = true;
    extraPackages = [
      # NOTE: avoid using this with zellij, since these pkgs are only be available in the nvim shell
    ];
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  # create a symlink to nvim binary for vscode-neovim
  home.activation.createNvimVsCodeLink =
    lib.hm.dag.entryAfter [ "writeBoundary" ] # sh
      ''
        mkdir -p $HOME/.local/bin
        ln -sf ${pkgs-unstable.neovim}/bin/nvim $HOME/.local/bin/nvim_vscode
      '';

  # create a symlink to lazyvim config inside the git repo (NOT the nix store link)
  home.activation.createNvimConfig =
    lib.hm.dag.entryAfter [ "writeBoundary" ] # sh
      ''
        rm -rf $HOME/.config/nvim
        ln -sf ${flakeVars.FLAKE_DOTS}/nvim $HOME/.config/nvim
      '';
  # ln -sf $HOME/nixos_config/nixos_flake/modules/user/dots/nvim $HOME/.config/nvim
  # NOTE: these don't work because relpaths point to the nix store flake path (read-only)
  # ln -sf ${../../../dots/nvim} $HOME/.config/nvim
  # ln -sf ${self}/dots/nvim $HOME/.config/nvim

  # environment.systemPackages = with pkgs;
  # [
  #   vimPlugins.codeium-vim
  # ];
}

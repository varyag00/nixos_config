{
  lib,
  flakeVars,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages =
    (with pkgs; [
      python312
      python312Packages.pip
      python312Packages.debugpy
      # NOTE: don't install poetry system-wide, it's more stable in a devshell
    ])
    ++ (with pkgs-unstable; [
      ruff # linter, formatter, and lsp server
      basedpyright # better pyright
      # ruff + basedpyright are used together: 
      # https://docs.astral.sh/ruff/editors/#language-server-protocol
    ]);

  # NOTE: if LD errors occur, you must either
  # 1. create devshell per project: 
  #   https://wiki.nixos.org/wiki/Python#Using_the_Nixpkgs_Python_infrastructure_via_shell.nix_(recommended)
  # 2. setup python packages nix-ld must be set up (see helpers.nix)
  #   https://wiki.nixos.org/wiki/Python#Setup_nix-ld
}

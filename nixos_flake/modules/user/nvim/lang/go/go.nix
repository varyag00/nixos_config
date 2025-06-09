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
      go
      gopls
      gofumpt
      gotools
      delve
      gotestsum
      golangci-lint
      golangci-lint-langserver
      gomodifytags
      impl # interface stubs
    ])
    ++ (with pkgs-unstable; [
      #
    ]);
}

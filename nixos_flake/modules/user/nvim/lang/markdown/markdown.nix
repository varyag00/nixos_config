{
  lib,
  flakeVars,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages = [
    pkgs.marksman
    # both mdlint-cli are required
    pkgs.markdownlint-cli # add markdownlint bin
    pkgs.markdownlint-cli2
  ];

  home.activation.createMarkdownConfigs =
    lib.hm.dag.entryAfter [ "writeBoundary" ] # sh
      ''
        mkdir -p "$HOME/.config/lsp"
        rm -rf "$HOME/.config/lsp/config.markdownlint-cli2.yaml"
        ln -sf ${flakeVars.FLAKE_DOTS}/lsp/config.markdownlint-cli2.yaml "$HOME/.config/lsp/config.markdownlint-cli2.yaml"
      '';
}

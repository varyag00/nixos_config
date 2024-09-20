{
  lib,
  envVars,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages = [
    pkgs.marksman
    pkgs.markdownlint-cli2
  ];

  home.activation.createMarkdownConfigs =
    lib.hm.dag.entryAfter [ "writeBoundary" ] # sh
      ''
        mkdir -p "$HOME/.config/lsp"
        rm -rf "$HOME/.config/lsp/markdownlint-cli2.yaml"
        ln -sf ${envVars.NIX_DOTS}/lsp/markdownlint-cli2.yaml "$HOME/.config/lsp/markdownlint-cli2.yaml"
      '';
}

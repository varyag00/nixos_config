{
  lib,
  envVars,
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
    ])
    ++ (with pkgs-unstable; [
      # 
    ]);
}

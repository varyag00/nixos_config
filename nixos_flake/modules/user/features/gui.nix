{
  flakeVars,
  pkgs,
  pkgs-unstable,
  ...
}:
{

  home.packages =
    if flakeVars.system.isGUI then
      [
        # 
        pkgs.neovide
      ]
    else
      [ ];
}

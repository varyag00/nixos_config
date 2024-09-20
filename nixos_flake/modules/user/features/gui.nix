{
  envVars,
  pkgs,
  pkgs-unstable,
  ...
}:
{

  home.packages =
    if envVars.system.isGUI then
      [
        # 
        pkgs.neovide
      ]
    else
      [ ];
}

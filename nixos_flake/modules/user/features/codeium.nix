{
  pkgs,
  pkgs-unstable,
  envVars,
  ...
}:
{
  home.packages =
    (with pkgs; [ ])
    ++ (with pkgs-unstable; [ ])
    ++ (
      if !envVars.system.isWork then
        [
          pkgs-unstable.codeium # in helpers.nix
        ]
      else
        [ ]
    );
}

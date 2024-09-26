{
  pkgs,
  pkgs-unstable,
  flakeVars,
  ...
}:
{
  home.packages =
    (with pkgs; [ ])
    ++ (with pkgs-unstable; [ ])
    ++ (
      if !flakeVars.system.isWork then
        [
          pkgs-unstable.codeium # in helpers.nix
        ]
      else
        [ ]
    );
}

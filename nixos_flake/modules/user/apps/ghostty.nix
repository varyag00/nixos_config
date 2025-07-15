{
  lib,
  pkgs,
  flakeVars,
  shellVars,
  ...
}:
let
  ghostty_config_dir = "${shellVars.XDG_CONFIG_HOME}/ghostty";
in
if flakeVars.system.isLinux then
  # TODO:
  { }
else if flakeVars.system.isDarwin then
  {
    # https://mynixos.com/home-manager/options/programs.ghostty
    # NOTE: use brew (mac-apps.nix) to install ghostty
    # programs.ghostty = {
    #   enable = true;
    # };

    # ln -sf ${flakeVars.FLAKE_DOTS}/ghostty/config ${ghostty_config_file}
    home.activation.ghosttyConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      rm -f ${ghostty_config_dir} 
      ln -sf ${flakeVars.FLAKE_DOTS}/ghostty ${ghostty_config_dir}
    '';
  }
else
  { }

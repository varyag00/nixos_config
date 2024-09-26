{ shellVars, ... }:
{
  # IDEA: move these to sh.nix if no extra logic is needed
  programs.zsh.sessionVariables = shellVars; # env vars exported in .zshrc
  home.sessionVariables = shellVars; # global env vars, set on user login
  # {
  #   FLAKE_DOTS = "${flakeVars.FLAKE_DOTS}";
  #   XDG_CONFIG_HOME = "${flakeVars.XDG_CONFIG_HOME}";
  #   CONFIG = "${flakeVars.XDG_CONFIG_HOME}";
  #   CFG = "${flakeVars.XDG_CONFIG_HOME}";
  #
  #   WORK_NOTES = "${flakeVars.flakeVars.WORK_NOTES}";
  #   MY_NOTES = "${flakeVars.flakeVars.MY_NOTES}";
  # };
}

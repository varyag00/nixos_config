{ shellVars, ... }:
{
  # IDEA: move these to sh.nix if no extra logic is needed
  programs.zsh.sessionVariables = shellVars; # env vars exported in .zshrc
  home.sessionVariables = shellVars; # global env vars, set on user login
  # {
  #   NIX_DOTS = "${envVars.NIX_DOTS}";
  #   XDG_CONFIG_HOME = "${envVars.XDG_CONFIG_HOME}";
  #   CONFIG = "${envVars.XDG_CONFIG_HOME}";
  #   CFG = "${envVars.XDG_CONFIG_HOME}";
  #
  #   WORK_NOTES = "${envVars.envVars.WORK_NOTES}";
  #   MY_NOTES = "${envVars.envVars.MY_NOTES}";
  # };
}

{ myEnvVars, ... }:
{
  # IDEA: move these to sh.nix if no extra logic is needed
  programs.zsh.sessionVariables = myEnvVars; # env vars exported in .zshrc
  home.sessionVariables = myEnvVars; # global env vars, set on user login
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

{
  lib,
  config,
  pkgs,
  pkgs-unstable,
  envVars,
  ...
}:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = false; # pls don't start on zsh start
    # NOTE: zellij config is symlinked below because .kdl settings are a pain in nix syntax
    # settings = {};
    # catppuccin.enable = true;
  };
  # create a symlink to zellij config and layouts
  home.activation.createZellijConfig =
    lib.hm.dag.entryAfter [ "writeBoundary" ] # sh
      ''
        rm -rf $HOME/.config/zellij
        ln -sf ${envVars.NIX_DOTS}/zellij $HOME/.config/zellij
      '';

  programs.zsh.shellAliases = {
    zl = "zellij";
    zel = "zellij";
  };
  # shell aliases
  programs.zsh.sessionVariables = {
    ZELLIJ_CONFIG = "$HOME/.config/zellij";
    ZELLIJ_LAYOUTS = "$HOME/.config/zellij/layouts";
    # NOTE: I define "session_layouts" as layouts that should be used to 
    ZELLIJ_SESSION_LAYOUTS = "$HOME/.config/zellij/session_layouts";
  };
  # NOTE: migrated to dots/zsh/extras/zellij.sh
  # programs.zsh.initExtra = "";
}

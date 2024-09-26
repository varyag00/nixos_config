# TODO: move this elsewhere
{
  lib,
  flakeVars,
  pkgs,
  pkgs-unstable,
  ...
}:
let
  # see https://nixos.wiki/wiki/Google_Cloud_SDK
  gdk-with-extras = pkgs.google-cloud-sdk.withExtraComponents (
    with pkgs.google-cloud-sdk.components; [ gke-gcloud-auth-plugin ]
  );
in
if flakeVars.system.isWork then
  {
    home.packages =
      (with pkgs; [
        # TODO: may requires API token (disabled on our instance), but check other sign-in methods
        # jira-cli-go
        # BUG: doesn't get added to PATH and can't be executed
        _1password # 1password cli, command "op"

        vault # takes forever to build; pls keep it pinned
        openshift # os CLI
        nodejs_22 # required for copilot-lua
        ansible
        sshpass
      ])
      ++ (with pkgs-unstable; [
        vimPlugins.copilot-lua
        # vimPlugins.CopilotChat-nvim
      ])
      ++ [ gdk-with-extras ];

    # create a symlink to work configs
    home.activation.createWorkConfigs =
      lib.hm.dag.entryAfter [ "writeBoundary" ] # sh
        ''
          rm -rf $HOME/.config/work
          ln -sf ${flakeVars.FLAKE_DOTS}/work $HOME/.config/work
        '';

    programs.zsh.sessionVariables = {
      WORK_ENV = if flakeVars.system.isWork then "1" else "0";
      HOME_ENV = if flakeVars.system.isWork then "0" else "1";
    };
  }
else
  { }

{ pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    kubectl
    kubectl-explore
    kubernetes-helm
    kind
    kubectx
  ];
  programs.k9s = {
    enable = true;
    package = pkgs-unstable.k9s;
    plugin = {
      # TODO: test out jq logs plugin
      # | https://mynixos.com/home-manager/option/programs.k9s.plugin
      # | https://github.com/derailed/k9s/blob/master/plugins/log-jq.yaml
      jqlogs = {
        shortCut = "Ctrl-L";
        confirm = false;
        description = "Logs (jq)";
        scopes = [ "po" ];
        command = "kubectl";
        background = false;
        args = [
          "jq"
          "$NAME"
          "$NAMESPACE"
          "$CONTEXT"
        ];
      };
    };
  };
  programs.zsh.shellAliases = {
    k = "kubectl";
    kctx = "kubectx";
    kct = "kubectx";
    kns = "kubens";
  };
}

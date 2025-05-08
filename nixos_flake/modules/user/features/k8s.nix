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
  };
  programs.zsh.shellAliases = {
    k = "kubectl";
    kctx = "kubectx";
    kns = "kubens";
  };
}

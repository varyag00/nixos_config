{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kubectl
    kubernetes-helm
    k9s
    kind
    kubectx
  ];
}

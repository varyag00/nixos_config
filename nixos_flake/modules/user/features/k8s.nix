{ pkgs, ... }:
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
    catppuccin.enable = true;
  };
  programs.zsh.shellAliases = {
    k = "kubectl";
    ktx = "kubectx";
    kns = "kubens";
  };
}

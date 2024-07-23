# NOTE: little experiment I'm running. Probably worth using devbox
{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
{
  home.packages =
    (with pkgs; [
      # unconfigurated stable packages
    ])
    ++ (with pkgs-unstable; [
      # unconfigurated unstable packages
    ]);

  # create a symlink to nvim binary for vscode-neovim
  home.activation.createDevShellSymlinks = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/dev-shells
    ln -sf ${../../../nix-shells} $HOME/dev-shells
  '';

  # environment.systemPackages = with pkgs;
  # [
  #   vimPlugins.codeium-vim
  # ];
}

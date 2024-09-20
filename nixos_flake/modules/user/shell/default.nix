{ ... }:
{
  imports = [
    ./zsh.nix
    # ./aliases.nix # NOTE: imported in zsh.nix
    ./env-vars.nix
    ./zellij.nix
    ./cli-apps.nix
    ./helpers.nix

    # TODO: feature toggles
    # ./work.nix
    # ./mac_dots.nix
  ];
}

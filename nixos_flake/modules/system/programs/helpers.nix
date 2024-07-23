{ config, inputs, pkgs, pkgs-unstable, ... }:

{
  # allow dynamically linked programs to be loaded
  # NOTE: required for:
  #   - vscode remote extension: https://nix-community.github.io/NixOS-WSL/how-to/vscode.html
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
    # NOTE: Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages

      # maybe?
      # pipx
    ];
    package = inputs.nix-ld-rs.packages."${pkgs.system}".nix-ld-rs;
  };

  # nix helper
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    # TODO: relative link to this flake, something like ${../../..}
    flake = "/home/dan/nixos_config/nixos_flake";
  };
}

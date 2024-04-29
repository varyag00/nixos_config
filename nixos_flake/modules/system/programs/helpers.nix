{ config, inputs, pkgs, userSettings, ... }:

{
  # allow dynamically linked programs to be loaded
  programs.nix-ld = {
    enable = true;
    # libraries = with pkgs; [
    #   # Add any missing dynamic libraries for unpackaged programs
    #   # here, NOT in environment.systemPackages
    # ];
    package = inputs.nix-ld-rs.packages."${pkgs.system}".nix-ld-rs;
  };

  # nix helper
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/dan/nixos_config/nixos_flake";
  };
}

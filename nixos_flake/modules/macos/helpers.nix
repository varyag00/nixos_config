{
  config,
  inputs,
  pkgs,
  pkgs-unstable,
  nh_darwin,
  ...
}:

{
  # TODO: programs.nix-ld doesn't exist (nix-darwin?)
  # # allow dynamically linked programs to be loaded
  # # NOTE: required for:
  # #   - vscode remote extension: https://nix-community.github.io/NixOS-WSL/how-to/vscode.html
  # programs.nix-ld = {
  #   enable = true;
  #   libraries = with pkgs; [
  #     # NOTE: Add any missing dynamic libraries for unpackaged programs
  #     # here, NOT in environment.systemPackages
  #
  #     # maybe?
  #     # pipx
  #   ];
  #   package = inputs.nix-ld-rs.packages."${pkgs.system}".nix-ld-rs;
  # };

  # nix helper
  environment.systemPackages = [
    # NOTE: programs.nh doesn't exist on nixpkgs-darwin, but it will after this is merged (after update):
    # https://github.com/LnL7/nix-darwin/pull/942
    # TODO: use programs.nh below instead of environment.systempackages
    nh_darwin.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  # programs.nh = {
  #   enable = true;
  #   clean.enable = true;
  #   clean.extraArgs = "--keep-since 4d --keep 3";
  #   # TODO: relative link to this flake, something like ${../../..}
  #   flake = "/home/dan/nixos_config/nixos_flake";
  # };
}

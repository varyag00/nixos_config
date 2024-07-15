{ pkgs, pkgs-unstable, ... }:
{
  home.packages = ( with pkgs; [
    # nix language server
    nil
  ]) ++ ( with pkgs; [
    nixfmt-rfc-style
  ]);
}

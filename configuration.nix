# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  # DOC: see this ticket: https://github.com/nix-community/NixOS-WSL/discussions/374
  # NOTE: removed these imports
  imports = [
  #  # include NixOS-WSL modules
  #  <nixos-wsl/modules>
    ./dan/config.nix
  ];
  # NOTE: moved global syspackages from dan/config.nix here in response to this comment 
  

  wsl.enable = true;
  # NOTE: updated from default "NixOS", and the ran the commands documented at url below
  # DOC: https://github.com/nix-community/NixOS-WSL/pull/406/files/379af73917816dd3d153b5862e648df3ba77ad32
  wsl.defaultUser = "dan";



  # NOTE: ./dan/config.nix contents:
  #environment.systemPackages = with pkgs; [ vim neovim git wget ];

  # enable flakes
  #nix.settings.experimental-features = [ "nix-command" "flakes" ];




  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

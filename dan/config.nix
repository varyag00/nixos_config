{ config, pkgs, ... }: {

  environment.systemPackages = with pkgs; [ neovim git wget ];

  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}

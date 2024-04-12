{ config, pkgs, ... }: {

  environment.systemPackages = with pkgs; [ vim neovim git wget ];

  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}

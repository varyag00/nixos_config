{ config, pkgs, ... }: {

  environment.systemPackages = with pkgs; 
  [ 
    zsh
    atuin
    neovim 
    git 
    wget
    ripgrep
    lsd
    fzf
    direnv
    bat
    dog
    zoxide
  ];

  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # configure user
  #main-user.enable = true;
  #main-user.userName = "dan";
}

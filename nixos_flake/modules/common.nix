{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Stockholm";

  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];

  users.defaultUserShell = pkgs.zsh;
  users.users.dan.shell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dan = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
    ];
    #packages = with pkgs; [
    #  firefox
    #  tree
    #];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    zsh
    wget
    gcc
    ripgrep
    procs # better ps
    git

    # tlrc # tldr in rust
    # nh # nix helper CLI

    # TODO: remove nodejs deps once i switch off mason
    # nodejs_21
    nodejs_22
    cargo # rust package manager
  ];
}

# Nixos Dotfiles

This repo include several different flakes for managing dotfiles.

I started with a basic working flake + nixos (including wsl support) in `00_minimal/`, then added home manager in `01_home-manager/`, then made the user config more module in `02_modular_home-manager/`.

Note that `hardware_configuration.nix` is not used for nixos on wsl.

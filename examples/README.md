# Examples
These examples illustrate different levels of nixos configuration:

- [00_minimal](./00_minimal/) demonstrates using a [flake](https://nixos.wiki/wiki/Flakes) to package a nixos system configuration. All configuration lives within the `configuration.nix`.
- [01_home-manager](./01_home_manager/) builds on `00_minimal` by keeping the flake, then adds and [home-manager](https://nix-community.github.io/home-manager/) to configure a nixos system. 

# Examples

These examples illustrate different nixos concepts and how they can be applied to configuring a system:

## [00_minimal](./00_minimal/)

This example demonstrates using a [flake](https://nixos.wiki/wiki/Flakes) to package a nixos system configuration.

To keep things as simple as possible, _all configuration_ lives within the [`configuration.nix`](./00_minimal/configuration.nix). To see possible configuration options, see [mynixos.com/nixpkgs/package](https://mynixos.com/search?q=nixpkgs%2Fpackage) and the [nixos docs](https://nixos.wiki/wiki/NixOS).

## [01_home-manager](./01_home_manager/)

This example expands upon [`00_minimal`](#00minimal00minimal)'s flake-based setup by adding [home-manager](https://nix-community.github.io/home-manager/) to manage user-level configuration.

Unlike `00_minimal`, `01_home-manager` puts user-level configuration in [`home.nix`](./01_home-manager/home.nix) (using home-manager) while keeping OS/system-level configuration in [`configuration.nix`](./01_home-manager/configuration.nix). 

`home-manager` has its own set of configuration [options](https://mynixos.com/home-manager/options) and [programs](https://mynixos.com/home-manager/options/programs) that are separate from nixos, see [home-manager docs](https://nix-community.github.io/home-manager/index.xhtml#ch-usage).

## [02_modular_home-manager](./02_modular_home-manager/)

This example expands upon [`01_home-manager`](#01home-manager01homemanager) by splitting the two configuration files ([`configuration.nix`](./02_modular_home-manager/profile/configuration.nix) and [`home.nix`](./02_modular_home-manager/profile/home.nix)) into [nix modules](https://nixos.wiki/wiki/NixOS_modules). The modules are stored under [modules](./02_modular_home-manager/modules/). 

It also introduces the concept of [profiles](./02_modular_home-manager/profile/) (though it only contains a single profile), which I use in my [main configuration](../nixos_flake/profiles/) to split configuration into reusable profiles.

Putting these patterns together allows us to write cleaner and more maintainable nix code.

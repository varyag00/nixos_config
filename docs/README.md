# Docs

## Commands

### System

- `nixos-rebuild switch`: rebuild the system using the `/etc/nixos/configuration.nix`
- `nixos-rebuild switch .`: rebuild the system using the configuration at CWD.
- `nixos-rebuild switch --flake .#dan`: to rebuild using the flake at CWD using the "dan" argument
- `home-manager switch --flake .#dan`: to switch to the home-manager configuration at CWD using the "dan" arg

### Nix

`nix-shell -p <package1> <package2> ...`: create a temporary shell including the specified packages.

## Glossary

- **flake**: a self-contained unit of nix configuration, which can be anything from a single package to a whole system configuration (e.g. [nixos_flake](./nixos_flake)). Flakes are composable, meaning that one flake can include other flakes.
- **derivation**: a description of a `nix build` task.
- **nix store**: the `/nix/store` contains all built and downloaded packages.

## NixOS Vs Nix

`Nix` is a package manager that can be used on any linux distro. NixOS is a linux distro built around and tightly coupled with `nix`.

`home-manager` can be used on any linux distro alongside `nix`, and together they bring most of the benefits of NixOS without much of the learning curve.

## Resources

- [mynixos.com](https://mynixos.com): user friendly nixos (and home-manager) package/program/option docs.
- [librephoenix nixos blog series](https://librephoenix.com/2023-10-21-intro-flake-config-setup-for-new-nixos-users.html): excellent blog series covering everything I do here and more.
- [bob vanderlinden's nix workshop slides](https://bobvanderlinden.github.io/nix-workshop/#/): slides to give an overview of the practical use cases of nix.
- [NixOS vs Ubuntu Cheatsheet](https://nixos.wiki/wiki/Ubuntu_vs._NixOS): illustrates common operations in Ubuntu and NixOS.
- [No Boilerplate's Everything, Everywhere, All At Once](https://www.youtube.com/watch?v=CwfKlX3rA6E): illustrates some of Nix's best selling points. Inspired me to check out NixOS.

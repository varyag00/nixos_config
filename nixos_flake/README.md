# Nixos Configuration

## Usage
1. Set `profile` in [flake.nix](./flake.nix) to the name of your desired profile (see [profiles/](./profiles/))
1. Ensure [flakes are enabled](https://nixos.wiki/wiki/Flakes) and `home-manager` and `git` are installed:
  - `nix-shell --experimental-features 'nix-command flakes' -p home-manager git`
1. `cd` into this directory then run `home-manager switch --flake .#dan`
## Components
- [modules/](./modules/): All nixos modules that are imported into this flake. Each module is self-contained and is intended to be directly importable.
- [modules/system/](./modules/system/): System and OS-level configuration modules that should be imported into the profile's `configuration.nix` file.
- [modules/user/](./modules/user/): User-level modules that would typically be configured under `$HOME/`.
- [profiles/](./profiles/): The different "flavours" of this flake for each of my machines.

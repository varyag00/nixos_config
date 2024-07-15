# helpful blog post: https://librephoenix.com/2023-11-02-how-to-manage-your-dotfiles-the-nix-way-with-home-manager#orgc8f3727
{
  description = "Nixos config flake";

  inputs = {
    # TODO: strongly consider switching nixpkgs to stable and creating nixpkgs-unstable
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ld-rs = {
      url = "github:nix-community/nix-ld-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixos-wsl, home-manager, ... }@inputs:
    let
      # SECTION: system settings
      systemSettings = {
        system = "x86_64-linux"; # system arch
        # NOTE: set profile to desired profile before running `home-manager switch --flake .#dan`
        profile = "wsl";
        timezone = "Europe/Stockholm"; # select timezone
        locale = "en_US.UTF-8"; # select locale
      };

      # SECTION: user settings
      userSettings = {
        username = "dan";
        name = "Dan G";
      };

      pkgs = nixpkgs.legacyPackages.${systemSettings.system};
    in
    {

      # SECTION: system-level configuration
      # NOTE: switch to this configuration using:
      #   `sudo nixos-rebuild switch --flake .`
      #   or
      #   `nh os switch .`
      #   in the dir containing this file
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
          inherit inputs;
        };
        system = systemSettings.system;
        modules = [
          # load {systemSettings.profile}/home.nix
          (./profiles + ("/" + systemSettings.profile) + "/configuration.nix")
          nixos-wsl.nixosModules.wsl
        ];
      };

      # SECTION: user-level configuration (i.e. dotfiles)
      homeConfigurations = {
        # NOTE: switch to this home-manager configuration using:
        #   `home-manager switch --flake .#dan`
        #   or
        #   `nh home switch -c dan .`
        dan = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit userSettings;
          };
          # system = systemSettings.system;
          modules = [
            # load {systemSettings.profile}/home.nix
            (./profiles + ("/" + systemSettings.profile) + "/home.nix")
          ];
        };
      };
    };
}

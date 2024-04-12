# helpful blog post: https://librephoenix.com/2023-11-02-how-to-manage-your-dotfiles-the-nix-way-with-home-manager#orgc8f3727
{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, ... }@inputs:
  let
    # SECTION: system settings
    systemSettings = {
      system = "x86_64-linux"; # system arch
      # hostname = "snowfire"; # hostname
      profile = "personal"; # select a profile defined from my profiles directory
      timezone = "Europe/Stockholm"; # select timezone
      locale = "en_US.UTF-8"; # select locale
    };

    # SECTION: user settings
    userSettings = {
      username = "dan";
      name = "Dan G";
    };

    pkgs = nixpkgs.legacyPackages.${systemSettings.system};
  in {

    # SECTION: system-level configuration
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit systemSettings;
      };
      system = systemSettings.system;
      modules = [
        # load {systemSettings.profile}/home.nix
        (./. + "/../profiles" + ("/" + systemSettings.profile) + "/configuration.nix")
        nixos-wsl.nixosModules.wsl
      ];
    };

    # SECTION: user-level configuration (i.e. dotfiles)
    homeConfigurations = {
      user = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit userSettings;
        };
        system = systemSettings.system;
        modules = [
          # load {systemSettings.profile}/home.nix
          (./. + "/../profiles" + ("/" + systemSettings.profile) + "/home.nix")
        ];
      };
    };
  };
}

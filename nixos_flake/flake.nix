# helpful blog post: https://librephoenix.com/2023-11-02-how-to-manage-your-dotfiles-the-nix-way-with-home-manager#orgc8f3727
{
  description = "Nixos config flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
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
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixos-wsl,
      home-manager,
      catppuccin,
      ...
    }@inputs:
    let
      # CRIT: set system vars in .envrc (and source) before applying flake

      # SECTION: .envrc imports
      username = builtins.getEnv "username";
      useremail = builtins.getEnv "useremail";
      system = builtins.getEnv "system";
      hostname = builtins.getEnv "hostname";
      systemFlake = builtins.getEnv "system_flake";
      is_work = builtins.getEnv "is_work";

      # SECTION: system settings
      systemSettings = {
        system = "x86_64-linux";
        # NOTE: set $NIXOS_CONFIG_PROFILE to desired profile before running
        profile = builtins.getEnv "NIXOS_CONFIG_PROFILE";
        timezone = "Europe/Stockholm";
        locale = "en_US.UTF-8";
      };

      # SECTION: user settings
      userSettings = {
        username = "dan";
        name = "Dan Gonzalez";
        email = "jdgonzal@proton.me";
      };

      # SECTION: env vars
      envVars = {
        # TODO: allow overriding this via env var
        NIX_DOTS = builtins.getEnv "HOME" + "/nixos_config/nixos_flake/dots";

        # TODO: fetch these from an .envrc file with direnv? what about for first install?
        user = {
          name = username;
          email = useremail;
        };
        system = {
          archname = system;
          hostname = hostname;
          isDarwin = builtins.elem envVars.system.archname [ "aarch64-darwin" ];
          isLinux = builtins.elem envVars.system.archname [ "x86_64-linux" ];
          isWork = is_work; # TODO: set from env var
        };
      };

      # nixpkg channel configuration
      pkgs = nixpkgs.legacyPackages.${systemSettings.system};

      pkgs-unstable = import nixpkgs-unstable {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };
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
          inherit envVars;
          inherit inputs;
          inherit pkgs-unstable;
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
            inherit systemSettings;
            inherit envVars;
            inherit pkgs-unstable;
          };
          # system = systemSettings.system;
          modules = [
            # load {systemSettings.profile}/home.nix
            (./profiles + ("/" + systemSettings.profile) + "/home.nix")
            catppuccin.homeManagerModules.catppuccin
          ];
        };
      };

      # nix code formatter
      # formatter.${envVars.system.archname} = nixpkgs.legacyPackages.${envVars.system.archname}.alejandra;
      formatter.${envVars.system.archname} =
        nixpkgs.legacyPackages.${envVars.system.archname}.nixfmt-rfc-style;
    };
}

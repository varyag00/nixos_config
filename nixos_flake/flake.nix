# helpful blog post: https://librephoenix.com/2023-11-02-how-to-manage-your-dotfiles-the-nix-way-with-home-manager#orgc8f3727
{
  description = "Nixos config flake";

  inputs = {
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # lock nixpkgs-unstable to commit
    nixpkgs-unstable.url = "github:nixos/nixpkgs/f85a2d005e83542784a755ca8da112f4f65c4aa4"; # 2024/10/07
    # Use this input to allow me to only tick hc tools, since they take forever to build
    nixpkgs-hashicorp.url = "github:nixos/nixpkgs/f85a2d005e83542784a755ca8da112f4f65c4aa4"; # 2024/10/07
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    # nh, but for darwin systems
    nh_darwin.url = "github:ToyVo/nh_darwin";
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
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-darwin,
      nixpkgs-unstable,
      nixpkgs-hashicorp,
      nixos-wsl,
      darwin,
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
      profile = builtins.getEnv "nixos_profile";
      flake = builtins.getEnv "FLAKE";
      isWork = builtins.getEnv "is_work" == "true";
      isGUI = builtins.getEnv "is_gui" == "true";
      isWSL = builtins.getEnv "is_wsl" == "true";
      isDarwin = builtins.elem system [ "aarch64-darwin" ];
      isLinux = builtins.elem system [ "x86_64-linux" ];

      # SECTION: flake variables -- used in nix code
      flakeVars = {
        FLAKE_DOTS = builtins.getEnv "HOME" + "/nixos_config/nixos_flake/dots";
        FLAKE_MODULES = builtins.getEnv "HOME" + "/nixos_config/nixos_flake/modules";

        user = {
          name = username;
          fullname = "Dan Gonzalez";
          email = useremail;
        };
        system = {
          profile = profile;
          timezone = "Europe/Stockholm";
          locale = "en_US.UTF-8";
          archname = system;
          hostname = hostname;
          isDarwin = isDarwin;
          # TODO: consider changing to isNixOS and/or isOtherLinux
          isLinux = isLinux;
          isWSL = isWSL;
          isWork = isWork;
          isGUI = isGUI;
        };
      };
      # END_SECTION: flake vars

      # SECTION: shell vars -- will be added as shell aliases
      shellVars = {
        FLAKE = flake;
        FLAKE_DOTS = flakeVars.FLAKE_DOTS;
        WORK = builtins.getEnv "HOME" + "/work";
        WORK_NOTES = shellVars.WORK + "/notes";
        WORK_ENV = if isWork then 1 else 0;

        # NOTE: cli apps don't always use this on mac, but it's worth setting for those that do
        XDG_CONFIG_HOME = builtins.getEnv "HOME" + "/.config";
        XDG_DATA_HOME = builtins.getEnv "HOME" + "/.local/share";
        XDG_CACHE_HOME = builtins.getEnv "HOME" + "/.cache";
        CONFIG = shellVars.XDG_CONFIG_HOME;
        CFG = shellVars.XDG_CONFIG_HOME;

        # TODO: optional; on windows I may just use obsidian.
        # consider settings in .envrc
        MY_NOTES = builtins.getEnv "HOME" + "/obsidian/obsidian-tasks";

        POWERLEVEL9K_INSTANT_PROMPT = "quiet";
      };
      # END_SECTION: shell vars

      nixpkgs-system = if flakeVars.system.isDarwin then nixpkgs-darwin else nixpkgs;

      pkgs = import nixpkgs-system {
        system = system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };
      pkgs-unstable = import nixpkgs-unstable {
        system = system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };

      pkgs-hc = import nixpkgs-hashicorp {
        system = system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };

      specialArgs = inputs // {
        inherit
          pkgs
          pkgs-unstable
          pkgs-hc
          flakeVars
          shellVars
          inputs
          ;
      };
    in
    {
      # SECTION: system-level configuration
      # NOTE: switch to this configuration using:
      #   `sudo nixos-rebuild switch --flake .`
      #   or
      #   `nh os switch .`
      #   in the dir containing this file
      nixosConfigurations =
        if flakeVars.system.isLinux then
          {
            nixos = nixpkgs.lib.nixosSystem {
              specialArgs = specialArgs;
              system = system;
              modules = [
                # load profile's configuration.nix
                (./profiles + ("/" + flakeVars.system.profile) + "/configuration.nix")
                nixos-wsl.nixosModules.wsl
              ];
            };
          }
        else
          { };

      # SECTION: user-level configuration (i.e. dotfiles)
      homeConfigurations =
        # if flakeVars.system.isLinux or flakeVars.system.isWSL then
        # FIXME: this should be truthy... does it even matter if they're all declared?
        if true then
          {
            # NOTE: switch to this home-manager configuration using:
            #   `home-manager switch --flake .#dan`
            #   or
            #   `nh home switch -c dan .`
            dan = home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              extraSpecialArgs = specialArgs;
              # system = systemSettings.system;
              modules = [
                # load profile's home.nix
                (./profiles + ("/" + flakeVars.system.profile) + "/home.nix")
                catppuccin.homeManagerModules.catppuccin
              ];
            };
          }
        else
          { };

      darwinConfigurations =
        if flakeVars.system.isDarwin then
          {
            "${flakeVars.system.hostname}" = darwin.lib.darwinSystem {
              specialArgs = specialArgs;
              system = flakeVars.system.archname;
              modules = [
                # BUG: home-manager programs.nh.package does not exist error...
                # probably need to update home-manager?
                # inputs.nh_darwin.nixDarwinModules.default

                # TODO: catppuccin flake for nixos
                # inputs.catppuccin.nixosModules.catppuccin

                (./profiles + ("/" + flakeVars.system.profile) + "/configuration.nix")

                # home manager
                home-manager.darwinModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.extraSpecialArgs = specialArgs;
                  home-manager.users.${flakeVars.user.name} = {
                    imports = [
                      (./profiles + ("/" + flakeVars.system.profile) + "/home.nix")
                      inputs.catppuccin.homeManagerModules.catppuccin
                    ];
                  };
                }
              ];
            };
          }
        else
          { };

      # nix code formatter
      formatter.${flakeVars.system.archname} =
        nixpkgs.legacyPackages.${flakeVars.system.archname}.nixfmt-rfc-style;
    };
}

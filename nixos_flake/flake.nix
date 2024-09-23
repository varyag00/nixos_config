# helpful blog post: https://librephoenix.com/2023-11-02-how-to-manage-your-dotfiles-the-nix-way-with-home-manager#orgc8f3727
{
  description = "Nixos config flake";

  inputs = {
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # lock nixpkgs-unstable to commit
    nixpkgs-unstable.url = "github:nixos/nixpkgs/294eb5975def0caa718fca92dc5a9d656ae392a9"; # 2024/20/09
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
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      profile = builtins.getEnv "nixos_profile";
      systemFlake = builtins.getEnv "system_flake";
      isWork = builtins.getEnv "is_work" == "true";
      isGUI = builtins.getEnv "is_gui" == "true";
      isWSL = builtins.getEnv "is_wsl" == "true";

      # SECTION: system settings
      systemSettings = {
        system = "x86_64-linux";
        # NOTE: set $NIXOS_CONFIG_PROFILE to desired profile before running
        profile = profile;
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
          isWork = isWork;
          isGUI = isGUI;
          isWSL = isWSL;
        };
      };
      # END_SECTION: env vars

      # SECTION: shell vars
      shellVars = {
        SYSTEM_FLAKE = systemFlake;
        NIX_DOTS = envVars.NIX_DOTS;
        # WORK = builtins.getEnv "HOME" + "/work";
        # FIXME: these are kinda redundant; only using in lazyvim config
        # HOME_ENV = if !isWork then 1 else 0;
        WORK_ENV = if isWork then 1 else 0;

        # NOTE: cli apps don't always use this on mac, but it's worth setting for those that do
        # XDG_CONFIG_HOME = builtins.getEnv "HOME" + "/.config";
        XDG_CONFIG_HOME = builtins.getEnv "HOME" + "/.config";
        XDG_DATA_HOME = builtins.getEnv "HOME" + "/.local/share";
        XDG_CACHE_HOME = builtins.getEnv "HOME" + "/.cache";
        CONFIG = shellVars.XDG_CONFIG_HOME;
        CFG = shellVars.XDG_CONFIG_HOME;

        # WORK_NOTES = builtins.elem myEnvVars.WORK + "/notes";
        # WORK_NOTES = myEnvVars.WORK + "/notes";
        # TODO: optional; on windows I may just use obsidian
        # MY_NOTES = builtins.getEnv "HOME" + "/obsidian/obsidian-tasks";
      };
      # END_SECTION: shellVars

      pkgs = import nixpkgs {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };
      pkgs-unstable = import nixpkgs-unstable {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };

      specialArgs = inputs // {
        inherit
          systemSettings
          userSettings
          pkgs
          pkgs-unstable
          envVars
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
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        # specialArgs = {
        #   inherit systemSettings;
        #   inherit userSettings;
        #   inherit envVars;
        #   inherit shellVars;
        #   inherit inputs;
        #   inherit pkgs;
        #   inherit pkgs-unstable;
        # };
        specialArgs = specialArgs;
        # OR: inherit specialArgs
        system = systemSettings.system;
        modules = [
          # load {systemSettings.profile}/home.nix
          (./profiles + ("/" + systemSettings.profile) + "/configuration.nix")
          nixos-wsl.nixosModules.wsl
        ]; # TODO: try this
        # ] ++ (if envVars.isWSL then [ nixos-wsl.nixosModules.wsl ] else [ ]);
      };

      # SECTION: user-level configuration (i.e. dotfiles)
      homeConfigurations = {
        # NOTE: switch to this home-manager configuration using:
        #   `home-manager switch --flake .#dan`
        #   or
        #   `nh home switch -c dan .`
        dan = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          # extraSpecialArgs = {
          #   inherit userSettings;
          #   inherit systemSettings;
          #   inherit envVars;
          #   inherit pkgs;
          #   inherit pkgs-unstable;
          # };
          extraSpecialArgs = specialArgs;
          # system = systemSettings.system;
          modules = [
            # load {systemSettings.profile}/home.nix
            (./profiles + ("/" + systemSettings.profile) + "/home.nix")
            catppuccin.homeManagerModules.catppuccin
          ];
        };
      };

      # nix code formatter
      formatter.${envVars.system.archname} =
        nixpkgs.legacyPackages.${envVars.system.archname}.nixfmt-rfc-style;
    };
}

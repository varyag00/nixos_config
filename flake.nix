{
  description = "NixOS config flake";

  inputs = {
    # TODO: make default stable, then use unstable.${pkg_name} in systempackages
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs = { self, nixpkgs, nixos-wsl, ... }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};  
  in
  {
    # DOC: see ticket https://github.com/nix-community/NixOS-WSL/discussions/374
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      # TODO: figure out why system can't be commented here
      system = "x86_64-linux";

      # take inputs of this flake and add inputs to all imported modules
      # NOTE: seems broken
      #extraSpecialArgs = {inherit inputs;};
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        nixos-wsl.nixosModules.wsl
	#./dan/user.nix
	inputs.home-manager.nixosModules.default
      ];
    };

    #packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
    #packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

  };


########  outputs = { self, nixpkgs, nixos-wsl, ... }@inputs: 
########    let
########      system = "x86_64-linux";
########      pkgs = nixpkgs.legacyPackages.${system};
########    in
########    { 
########      # DOC: see ticket https://github.com/nix-community/NixOS-WSL/discussions/374
########      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
########	#extraSpecialArgs = {inherit inputs;};
########	modules = [
########	  ./configuration.nix
########	  nixos-wsl.nixosModules.wsl
########	];
########      };

########      #packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
########      #packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

########    };
}

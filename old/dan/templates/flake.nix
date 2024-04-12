{
  description = "A very basic flake";

  inputs = {
    # TODO: make default stable, then use unstable.${pkg_name} in systempackages
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl";

  };

  outputs = { self, nixpkgs, nixos-wsl }: {
    
    # DOC: see ticket https://github.com/nix-community/NixOS-WSL/discussions/374
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        nixos-wsl.nixosModules.wsl
      ];
    };

    #packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
    #packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

  };
}

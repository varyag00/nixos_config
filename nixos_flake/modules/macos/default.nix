{ ... }:
{
  imports = [
    ./host-users.nix
    ./mac-apps.nix
    #./nix-core.nix
    ./system.nix
    ./helpers.nix
  ];
  # for determinate-nix
  nix.enable = false;
}

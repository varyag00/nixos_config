{
  envVars,
  pkgs,
  pkgs-unstable,
  # nh_darwin,
  ...
}:
{
  # environment.systemPackages = with pkgs; [ nh ];
  home.packages =
    [
      # install everywhere
    ]
    ++ (
      # TODO: look into builtins.currentSystem, which gives you the currently set system
      if envVars.system.isLinux then
        [
          pkgs-unstable.nh # in helpers.nix
          pkgs.clair # container static analysis
        ]
      else if envVars.system.isDarwin then
        [
          # pkgs-unstable.nh_darwin # doesn't exist; override 
        ]
      else
        [ ]
    );

  # # nh config
  # programs.nh =
  #   if envVars.system.isLinux then
  #     {
  #       enable = true;
  #       package = pkgs-unstable.nh;
  #     }
  #   else if envVars.system.isDarwin then
  #     {
  #       enable = true;
  #       # Installation option once https://github.com/LnL7/nix-darwin/pull/942 is merged:
  #       # package = nh_darwin.packages.${pkgs.stdenv.hostPlatform.system}.default;
  #     }
  #   else
  #     { };

  programs.zsh.shellAliases.nh =
    if envVars.system.isLinux then
      "nh"
    else if envVars.system.isDarwin then
      "nh_darwin"
    else
      null;

  # programs.nix-ld = {
  #   enable = true;
  #   libraries = [
  #     # pkgs-unstable.libc
  #     # pkgs.something
  #   ];
  #   package = pkgs-unstable.nix-ld-rs;
  # };
}

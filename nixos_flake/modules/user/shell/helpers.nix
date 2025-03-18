{
  flakeVars,
  pkgs,
  pkgs-unstable,
  nh_darwin,
  ...
}:
if flakeVars.system.isDarwin then
  {
    # TODO: look into builtins.currentSystem, which gives you the currently set system
    home.packages = [
      # pkgs-unstable.nh_darwin # doesn't exist; override
    ];

    # # nix helper CLI tool
    # programs.nh = {
    #   enable = true;
    #   clean.enable = true;
    #   clean.extraArgs = "--keep-since 7d --keep 3";
    # };
    #
    # # nh config
    # programs.nh = {
    #   enable = true;
    #   # Installation option once https://github.com/LnL7/nix-darwin/pull/942 is merged:
    #   # package = nh_darwin.packages.${pkgs.stdenv.hostPlatform.system}.default;
    # };

    # programs.zsh.shellAliases.nh = "nh_darwin";

    # programs.nix-ld = {
    #   enable = true;
    #   libraries = [
    #     # pkgs-unstable.libc
    #     # pkgs.something
    #   ];
    #   package = pkgs-unstable.nix-ld-rs;
    # };
  }
else if flakeVars.system.isLinux || flakeVars.system.isWSL then
  {
    # TODO: look into builtins.currentSystem, which gives you the currently set system
    home.packages = [
      pkgs-unstable.nh # in helpers.nix
      pkgs.clair # container static analysis
    ];

    # # nh config
    # programs.nh = {
    #   enable = true;
    #   package = pkgs-unstable.nh;
    # };
    # programs.zsh.shellAliases.nh = "nh";
    #
    # programs.nix-ld = {
    #   enable = true;
    #   libraries = [
    #     # pkgs-unstable.libc
    #     # pkgs.something
    #   ];
    #   package = pkgs-unstable.nix-ld-rs;
    # };
  }
else
  { }

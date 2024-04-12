{ lib, config, pkgs, ... }: 

#let
#  cfg = config.main-user;
#in
{
  options = {
    main-user.enable = lib.mkEnableOption "enable user module";
    main-user.userName = lib.mkOption {
      default = "dan";
      description = ''
        username
      '';
    };
  };

  config = lib.mkIf config.user.enable {
    users.users.${config.main-user.userName} = {
      isNormalUser = true;
      initialPassword = "foobar";
      description = "main user";
      shell = pkgs.zsh;
    };
  };
}

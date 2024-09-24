# NOTE: A function that expects a set with required attributes x and y, and binds the whole set to args
{ envVars, ... }@args:
#############################################################
#
#  Host & Users configuration
#
#############################################################
let
  username = envVars.user.name;
  hostname = envVars.system.hostname;
in
{
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    home = "/Users/${username}";
    description = username;
  };

  nix.settings.trusted-users = [ username ];
}

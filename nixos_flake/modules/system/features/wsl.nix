{
  config,
  inputs,
  pkgs,
  userSettings,
  ...
}:

{
  wsl.enable = true;
  wsl.defaultUser = userSettings.username;
}

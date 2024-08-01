{
  config,
  inputs,
  pkgs,
  userSettings,
  ...
}:

{
  # https://nix-community.github.io/NixOS-WSL/options.html
  wsl.enable = true;
  wsl.defaultUser = userSettings.username;
  # use windows OpenGL driver; required for nvidia-container-toolkit (GPU containers)
  wsl.useWindowsDriver = true;
}

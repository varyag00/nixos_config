{
  config,
  inputs,
  pkgs,
  envVars,
  ...
}:
if envVars.system.isWSL then
  {
    # https://nix-community.github.io/NixOS-WSL/options.html
    wsl.enable = true;
    wsl.defaultUser = envVars.user.name;
    # use windows OpenGL driver; required for nvidia-container-toolkit (GPU containers)
    wsl.useWindowsDriver = true;
  }
else
  { }

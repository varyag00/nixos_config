{
  config,
  inputs,
  pkgs,
  flakeVars,
  ...
}:
if flakeVars.system.isWSL then
  {
    # https://nix-community.github.io/NixOS-WSL/options.html
    wsl.enable = true;
    wsl.defaultUser = flakeVars.user.name;
    # use windows OpenGL driver; required for nvidia-container-toolkit (GPU containers)
    wsl.useWindowsDriver = true;
  }
else
  { }

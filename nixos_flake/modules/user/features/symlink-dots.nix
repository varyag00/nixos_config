{
  envVars,
  lib,
  pkgs,
  ...
}:
if envVars.system.isDarwin then
  {
    # aerospace
    home.activation.aerospaceConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      rm -rf $HOME/.config/aerospace
      ln -sf ${envVars.FLAKE_DOTS}/mac/aerospace $HOME/.config/aerospace
    '';

    # borders around aerospace's active window
    home.activation.bordersConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      rm -rf $HOME/.config/borders
      ln -sf ${envVars.FLAKE_DOTS}/mac/borders $HOME/.config/borders
    '';

    # set wallpaper
    home.activation.setWallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      /usr/local/bin/desktoppr ${envVars.FLAKE_DOTS}/wallpapers/nixos-catppuccin-macchiato.png
    '';

    # karabiner-elements (single file)
    home.activation.karabinerConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "$HOME/.config/karabiner"
      rm -rf "$HOME/.config/karabiner/karabiner.json"
      ln -sf ${envVars.FLAKE_DOTS}/mac/karabiner/karabiner.json $HOME/.config/karabiner/karabiner.json
    '';

    # TODO: move these to another module

    # wezterm
    home.activation.weztermConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      rm -rf $HOME/.config/wezterm
      ln -sf ${envVars.FLAKE_DOTS}/wezterm $HOME/.config/wezterm
    '';

    # qutebrowser
    # NOTE: qutebrowser uses $HOME/.qutebrowser on macOS and $HOME/.config/qutebrowser on Linux
    # NOTE: don't use home-manager module because I use this on windows too
    home.activation.qutebrowserConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      rm -rf $HOME/.qutebrowser
      ln -sf ${envVars.FLAKE_DOTS}/qutebrowser $HOME/.qutebrowser
    '';
  }
else if envVars.system.isWSL then
  {
    # TODO: symlink wezterm and qutebrowser to /mnt/c/... windows location
  }
else if envVars.system.isLinux then
  { }
else
  { }

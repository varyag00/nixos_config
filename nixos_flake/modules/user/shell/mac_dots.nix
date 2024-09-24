# TODO: move to modules/macos/ ?
{
  envVars,
  lib,
  pkgs,
  ...
}:
{
  # TODO: refactor dots. 
  # IDEA: "feature modules" with correct relpaths from $XDG_CONFIG_HOME,
  # - Benefits: 
  # - one entryAfter per feature: I don't need to create a new entryAfter for every new dot 
  # - easy to toggle on-and-off from envVars
  #   - can more easily coordinate with corresponding home-manager module
  # Something like:
  # home.activation.desktopDots = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   # loop through each subdir in dots/mac_desktop and fetch its target_path
  #   # pseudocode
  #   for name, target_config_path in {envVars.NIX_DOTS}features/mac_desktop:
  #   rm -rf {target_config_path}
  #   ln -sf ${envVars.NIX_DOTS}/feature/mac_desktop/{name} {target_config_path}
  # '';
  # - Questions: How do you get the name of each file?
  # IDEA: just use a single nix module for each feature, kinda like what I'm doing here

  # aerospace
  home.activation.aerospaceConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    rm -rf $HOME/.config/aerospace
    ln -sf ${envVars.NIX_DOTS}/mac/aerospace $HOME/.config/aerospace
  '';

  # borders around aerospace's active window
  home.activation.bordersConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    rm -rf $HOME/.config/borders
    ln -sf ${envVars.NIX_DOTS}/mac/borders $HOME/.config/borders
  '';

  # set wallpaper
  home.activation.setWallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    /usr/local/bin/desktoppr ${envVars.NIX_DOTS}/wallpapers/nixos-catppuccin-macchiato.png
  '';

  # karabiner-elements (single file)
  home.activation.karabinerConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.config/karabiner"
    rm -rf "$HOME/.config/karabiner/karabiner.json"
    ln -sf ${envVars.NIX_DOTS}/mac/karabiner/karabiner.json $HOME/.config/karabiner/karabiner.json
  '';

  # TODO: move these to another module

  # wezterm
  home.activation.weztermConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    rm -rf $HOME/.config/wezterm
    ln -sf ${envVars.NIX_DOTS}/wezterm $HOME/.config/wezterm
  '';

  # qutebrowser
  # NOTE: qutebrowser uses $HOME/.qutebrowser on macOS and $HOME/.config/qutebrowser on Linux
  # NOTE: don't use home-manager module because I use this on windows too
  home.activation.qutebrowserConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    rm -rf $HOME/.qutebrowser
    ln -sf ${envVars.NIX_DOTS}/qutebrowser $HOME/.qutebrowser
  '';
}

{
  flakeVars,
  lib,
  pkgs,
  ...
}:
if flakeVars.system.isDarwin then
  {
    # aerospace
    home.activation.aerospaceConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      rm -rf $HOME/.config/aerospace
      ln -sf ${flakeVars.FLAKE_DOTS}/mac/aerospace $HOME/.config/aerospace
    '';

    # borders around aerospace's active window
    home.activation.bordersConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      rm -rf $HOME/.config/borders
      ln -sf ${flakeVars.FLAKE_DOTS}/mac/borders $HOME/.config/borders
    '';
    # TODO: see if this alias works well
    programs.zsh.shellAliases.ff = "aerospace list-windows --all | fzf --bind 'enter:execute(bash -c \"aerospace focus --window-id {1}\")+abort'";

    # set wallpaper
    home.activation.setWallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      /usr/local/bin/desktoppr ${flakeVars.FLAKE_DOTS}/wallpapers/nixos-catppuccin-macchiato.png
    '';

    # BUG: karabiner doesn't reload the file; it seems to create duplicates (bad merges?)
    # # karabiner-elements (single file)
    # home.activation.karabinerConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    #   mkdir -p "$HOME/.config/karabiner"
    #   rm -rf "$HOME/.config/karabiner/karabiner.json"
    #   ln -sf ${flakeVars.FLAKE_DOTS}/mac/karabiner/karabiner.json $HOME/.config/karabiner/karabiner.json
    # '';

    # qutebrowser
    # NOTE: qutebrowser uses $HOME/.qutebrowser on macOS and $HOME/.config/qutebrowser on Linux
    # NOTE: don't use home-manager module because I use this on windows too
    home.activation.qutebrowserConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      rm -rf $HOME/.qutebrowser
      ln -sf ${flakeVars.FLAKE_DOTS}/qutebrowser $HOME/.qutebrowser
    '';
  }
else if flakeVars.system.isWSL then
  {
    # TODO: symlink wezterm and qutebrowser to /mnt/c/... windows location
  }
else if flakeVars.system.isLinux then
  { }
else
  { }

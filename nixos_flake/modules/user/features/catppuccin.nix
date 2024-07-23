{ pkgs, catppuccin, ... }:
{
  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "lavender";

    # GUI stuff
    # pointerCursor = {
    #   enable = true;
    #   flavor = "macchiato";
    #   accent = "lavender";
    # };
    # gtk.catppuccin = {
    #   enable = true;
    #   flavor = "macchiato";
    #   accent = "lavender";
    #   gnomeShellTheme = true;
    #   icon = {
    #     enable = true;
    #     flavor = "macchiato";
    #     accent = "lavender";
    #   };
    # }


  };

  programs.neovim.catppuccin.enable = false;
}

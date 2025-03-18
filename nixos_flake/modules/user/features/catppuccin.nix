{ pkgs, catppuccin, ... }:
{
  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "lavender";

    nvim.enable = false; # set in nvim lua config
    zellij.enable = false; # see zellij.nix
    yazi.enable = true;
    lazygit.enable = true;
    gh-dash.enable = true;
    fzf.enable = true;
    delta.enable = true;
    btop.enable = true;
    bat.enable = true;
    zsh-syntax-highlighting.enable = true;

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

  # programs.neovim.catppuccin.enable = false;
}

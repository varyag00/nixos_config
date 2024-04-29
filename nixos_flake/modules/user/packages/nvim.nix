{ pkgs, ... }:
{
  # NOTE: home-manager switch complains about collissions
  # home.packages = with pkgs; [ neovim ];
  # programs.neovim = {
  #   # see options https://mynixos.com/home-manager/options/programs.neovim
  #   enable = true;
  #   defaultEditor = true;
  # };

  # create a symlink of existing nvim config
  home.file.".config/nvim" = {
    source = ../dots/nvim;
    recursive = true;
  };

  # environment.systemPackages = with pkgs;
  # [
  #   vimPlugins.codeium-vim
  # ];
}

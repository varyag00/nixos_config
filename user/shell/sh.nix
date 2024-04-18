{ pkgs, ... }:

# TODO: pull dotfiles from dotfiles dir, see 
# https://github.com/mickours/nixos-config/blob/6694179962931efc54e802a61c7bff5b51ff8329/config/home.nix#L3

let
  myAliases = {
    ls = "lsd";
    la = "lsd -lah";
    ll = "lsd -l";
    # TODO: ensure z command is installed by zoxide
    cd = "z";
    cdi = "zi";
    cat = "bat";
    vim = "nvim";
    vi = "nvim";
    tf = "terraform";
    lgit = "lazygit";
    ldoc = "lazydocker";
  };
in {
  home.packages = with pkgs; [ zsh-powerlevel10k bat dog zoxide lsd bottom fd bc direnv nix-direnv atuin fzf ];
  # p10k config
  home.file.".p10k.zsh".text = builtins.readFile ../dots/zsh/.p10k.zsh;

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    initExtraBeforeCompInit = builtins.readFile ../dots/zsh/init_p10k.zsh;
    # TODO: .zshrc from dotfiles repo, see top of file
    initExtra = builtins.readFile ../dots/zsh/.zshrc;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
    # initExtra = ''
    # PROMPT=" ◉ %U%F{magenta}%n%f%u@%U%F{blue}%m%f%u:%F{yellow}%~%f
    #  %F{green}→%f "
    # RPROMPT="%F{red}▂%f%F{yellow}▄%f%F{green}▆%f%F{cyan}█%f%F{blue}▆%f%F{magenta}▄%f%F{white}▂%f"
    # [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
    # '';


    # TODO: entire .zshrc, plugins, aliases
    # plugins, see https://github.com/mickours/nixos-config/blob/6694179962931efc54e802a61c7bff5b51ff8329/config/my_vim_plugins.nix
  };
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      show_preview = false;
      inline_height = 25;
    };
  };
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    # TODO: add fzf custom functions from dotfiles
  };
  programs.bat = {
    enable = true;
    config = {
      theme = "base16";
    };
  };
}

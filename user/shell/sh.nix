{ pkgs, ... }:

let
  myAliases = {
    ls = "lsd";
    la = "lsd -lah";
    ll = "lsd -l";
    # TODO: ensure z command is installed by zoxide
    #cd = "z";
    #cdi = "zi";
    cat = "bat";
    vim = "nvim";
    vi = "nvim";
    tf = "terraform";
    lgit = "lazygit";
    ldoc = "lazydocker";
  };
in {
  programs.zsh = {
    enable = true;
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

    # TODO: p10k config
    # TODO: entire .zshrc, plugins, aliases
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

  home.packages = with pkgs; [ bat lsd bottom fd bc direnv nix-direnv atuin ];

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
}

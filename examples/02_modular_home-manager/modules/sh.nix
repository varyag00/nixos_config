{ pkgs, ... }:

let
  myAliases = {
    ls = "lsd";
    la = "lsd -lah";
    ll = "lsd -l";
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
  home.packages = with pkgs; [ bat dog zoxide lsd bottom fd bc direnv nix-direnv atuin fzf ];
  # p10k config
  home.file.".config/zsh/.p10k.zsh".text = builtins.readFile ../dots/zsh/.p10k.zsh;

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    # TODO: .zshrc from dotfiles repo, see top of file
    initExtraBeforeCompInit = builtins.readFile ../dots/zsh/init_p10k.zsh;
    # NOTE: think about what i actually need from my .zshrc
    
    # TODO: test this slimmed down zshrc
    initExtra = builtins.readFile ../dots/zsh/.zshrc-slim;
    
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  
    zplug = {
      enable = true;
      plugins = [
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
        { name = "jeffreytse/zsh-vi-mode"; }
        #{ name = "plugins/git"; tags = [ from:oh-my-zsh ]; }
      ];
    };

    #initExtra = ''
    #  source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    #'';
    

    #oh-my-zsh = {
    #  enable = true;
    #  theme = "robbyrussell";
    #};
    #envExtra = "POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true";
    #prezto = {
    #  enable = true;
      #extraConfig = "zstyle :prezto:module:prompt theme powerlevel10k";
    #  prompt.theme = "powerlevel10k";
      #prompt.theme = "sorin";
    #};

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

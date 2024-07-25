{ pkgs, envVars, ... }:

# TODO: pull dotfiles from dotfiles dir, see
# https://github.com/mickours/nixos-config/blob/6694179962931efc54e802a61c7bff5b51ff8329/config/home.nix#L3

let
  myAliases = import ./aliases.nix;
in
{
  # p10k config
  home.file.".config/zsh/.p10k.zsh".text = builtins.readFile ../../../dots/zsh/.p10k.zsh;

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    envExtra = ''
      export KEYTIMEOUT=1

      export NAP_HOME="$HOME/.config/nap/snippets";
      export NAP_CONFIG="$HOME/.config/nap/config.yaml";
    '';

    initExtraBeforeCompInit = builtins.readFile ../../../dots/zsh/init_p10k.zsh;

    initExtra = builtins.readFile ../../../dots/zsh/.zshrc-slim;

    # this is very ugly
    # autosuggestion.highlight = "fg=#ff00ff,bg=cyan,bold,underline";
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = myAliases;

    zplug = {
      enable = true;
      plugins = [
        {
          name = "romkatv/powerlevel10k";
          tags = [
            "as:theme"
            "depth:1"
          ];
        } # Installations with additional options. For the list of options, please refer to Zplug README.
        { name = "jeffreytse/zsh-vi-mode"; }
        { name = "Berger91/taskfile-zsh-autocompletion"; }
        #{ name = "plugins/git"; tags = [ from:oh-my-zsh ]; }
      ];
    };

    #initExtra = ''
    #  source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    #'';

    # initExtra = ''
    # PROMPT=" ◉ %U%F{magenta}%n%f%u@%U%F{blue}%m%f%u:%F{yellow}%~%f
    #  %F{green}→%f "
    # RPROMPT="%F{red}▂%f%F{yellow}▄%f%F{green}▆%f%F{cyan}█%f%F{blue}▆%f%F{magenta}▄%f%F{white}▂%f"
    # [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
    # '';

    # TODO: review entire .zshrc, plugins, aliases
    # plugins, see https://github.com/mickours/nixos-config/blob/6694179962931efc54e802a61c7bff5b51ff8329/config/my_vim_plugins.nix
  };
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };
}

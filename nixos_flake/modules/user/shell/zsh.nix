{
  lib,
  pkgs,
  envVars,
  ...
}:

# TODO: pull dotfiles from dotfiles dir, see
# https://github.com/mickours/nixos-config/blob/6694179962931efc54e802a61c7bff5b51ff8329/config/home.nix#L3

let
  # TODO: specify aliases directly in aliases.nix (i.e. programs.zsh.aliases = ...)
  myAliases = import ./aliases.nix;
in
{
  # use home-manager's top-level XDG module
  xdg = {
    # NOTE: by default XDG is not used in darwin, but enabling it makes most programs use it without problems
    # know exceptions: karabiner
    enable = true;
  };

  # create a symlink to work configs
  home.activation.createZshExtrasConfigs =
    lib.hm.dag.entryAfter [ "writeBoundary" ] # sh
      ''
        rm -rf $HOME/.config/zsh/extras
        ln -sf ${envVars.FLAKE_DOTS}/zsh/extras $HOME/.config/zsh/extras
      '';

  # p10k config
  home.file.".config/zsh/.p10k.zsh".text = builtins.readFile "${envVars.FLAKE_DOTS}/zsh/.p10k.zsh";

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    shellAliases = myAliases;

    initExtraBeforeCompInit = builtins.readFile "${envVars.FLAKE_DOTS}/zsh/init_p10k.zsh";

    initExtra = builtins.readFile "${envVars.FLAKE_DOTS}/zsh/.zshrc-slim";

    # this is very ugly
    # autosuggestion.highlight = "fg=#ff00ff,bg=cyan,bold,underline";
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      catppuccin.enable = true;
    };
    enableCompletion = true;

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
    plugins = [
      # from https://discourse.nixos.org/t/darwin-home-manager-zsh-fzf-and-zsh-fzf-tab/33943/4
      # TODO: use newer commit
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "c2b4aa5ad2532cca91f23908ac7f00efb7ff09c9";
          sha256 = "1b4pksrc573aklk71dn2zikiymsvq19bgvamrdffpf7azpq6kxl2";
        };
      }
    ];

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

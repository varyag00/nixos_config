{
  config,
  pkgs,
  pkgs-unstable,
  userSettings,
  ...
}:

{
  home.packages =
    (with pkgs; [
      dog
      lsd
      bottom
      fd
      jq
      yq
      bc
      lazygit
      lazydocker
      thefuck
      # code snippets TUI
      nap
      hurl
      go-task
      tre-command
    ])
    ++ (with pkgs-unstable; [
      # simpler nix-shell
      devbox
      # sql TUI
      lazysql
      # http API testing TUI
      slumber
      # standalone magit TUI
      gitu
    ]);
  programs.git = {
    enable = true;
    userName = userSettings.name;
    userEmail = userSettings.email;
    extraConfig = {
      core = {
        editor = "nvim";
      };
      color = {
        ui = true;
      };
      push = {
        default = "simple";
      };
      pull = {
        ff = "only";
      };
      init = {
        defaultBranch = "main";
      };
    };
    aliases = {
      lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
      lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
      co = "checkout";
    };
    ignores = [
      ".DS_Store"
      "*.pyc"
      ".vscode/*"
    ];
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        # overridden by catppuccin.nix
        # dark = true;
      };
    };
  };
  programs.zellij = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      theme = "catppuccin-macchiato";
    };
  };
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
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
      # theme = "base16";
    };
  };
  programs.lazygit = {
    enable = true;
    settings = {
      # catppuccin macchiato lavender:
      # https://github.com/catppuccin/lazygit/blob/21a25afd92327ddea8446ab9171ca7039b431e9e/themes-mergable/macchiato/lavender.yml
      gui = {
        theme = {
          activeBorderColor = [
            "#b7bdf8"
            "bold"
          ];
          inactiveBorderColor = [ "#a5adcb" ];
          optionsTextColor = [ "#8aadf4" ];
          selectedLineBgColor = [ "#363a4f" ];
          cherryPickedCommitBgColor = [ "#494d64" ];
          cherryPickedCommitFgColor = [ "#b7bdf8" ];
          unstagedChangesColor = [ "#ed8796" ];
          defaultFgColor = [ "#cad3f5" ];
          searchingActiveBorderColor = [ "#eed49f" ];
        };
        authorColors = {
          "*" = "#b7bdf8";
        };
      };
    };
  };
}

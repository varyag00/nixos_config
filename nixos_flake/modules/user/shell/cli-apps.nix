{
  lib,
  config,
  pkgs,
  pkgs-unstable,
  nh_darwin,
  flakeVars,
  ...
}:

{
  home.packages =
    (with pkgs; [
      dog
      lsd
      bottom
      ripgrep
      ast-grep # rg for codebases, with context
      fd
      jq
      # interative jq
      jid
      yq
      bc
      lazygit
      lazydocker
      # thefuck
      tealdeer # rust tldr client
      # tlrc # rust tldr client -- problems on macos

      # terminal colors
      dwt1-shell-color-scripts
      # code snippets TUI
      nap
      hurl # http API testing tool
      # NOTE: also installed via brew on macos
      bruno # http API testing tool
      atac # http TUI
      runme # run-able markdown files
      go-task
      tre-command
      gping
      # presentation slides in terminal
      slides
      # browser bookmarks
      buku

      # encryption tool w/ great UX
      age
      # secrets operations
      sops
      # easy file transfer tool; pairs great with age
      portal

      # double-entry bookkeeping
      hledger
      hledger-ui # ledger tui
      # hledger-web # ledger gui; this is like 3 GB of packages...
      puffin # better ledger tui
    ])
    ++ (with pkgs-unstable; [
      # stable version is too old
      # terraform
      tftui
      # simpler nix-shell
      devbox
      # sql TUIs
      lazysql
      dblab
      # http API testing TUI
      slumber
      # github cli and extensions
      # gh
      # gh-notify
      # standalone magit TUI
      gitu
      # git absorb = better git fixups
      git-absorb
      # better dig (dns)
      doggo
      # ssh TUI
      sshs # TODO: sshs or wishlist?

      # charm.sh packages
      gum # better shell scripts: https://github.com/charmbracelet/gum
      mods # CLI chatbot interface: https://github.com/charmbracelet/mods
      vhs # code gif recording utility: https://github.com/charmbracelet/vhs
      charm-freeze # code screenshot utility: https://github.com/charmbracelet/freeze
      glow # markdown previewer tui
      melt # ssh key restore
      wishlist # ssh TUI
    ])
    ++ (
      if flakeVars.system.isLinux then
        [
          # pkgs-unstable.nh # in helpers.nix
          # pkgs.clair container static analysis
        ]
      else if flakeVars.system.isDarwin then
        [
          # docker VM on macos
          pkgs-unstable.colima
          pkgs.docker

          # TODO: uncomment when this gets added back
          # need to install nh as system module because home-manager is acting strange
          nh_darwin.packages.${pkgs.stdenv.hostPlatform.system}.default

          # archives
          pkgs.zip
          pkgs.xz
          pkgs.unzip
          pkgs.p7zip

          pkgs.aria2 # A lightweight multi-protocol & multi-source command-line download utility
          pkgs.socat # replacement of openbsd-netcat
          pkgs.nmap # A utility for network discovery and security auditing

          # misc
          pkgs.cowsay
          pkgs.file
          pkgs.which
          pkgs.gnused
          pkgs.gnutar
          pkgs.gawk
          pkgs.zstd
          pkgs.caddy
          pkgs.gnupg
        ]
      else
        [ ]
    );

  programs.git = {
    enable = true;
    userName = flakeVars.user.name;
    userEmail = flakeVars.user.email;
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
      catppuccin.enable = true;
      options = {
        navigate = true;
        line-numbers = true;
      };
    };
  };
  programs.btop = {
    enable = true;
    catppuccin.enable = true;
  };
  programs.yazi = {
    # yazi is under active development
    package = pkgs-unstable.yazi;
    enable = true;
    enableZshIntegration = true;
    catppuccin.enable = true;
    settings = {
      manager.show_hidden = true;
    };
  };
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      show_preview = false;
      # inline_height = 25;
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
    catppuccin.enable = true;
    # TODO: add fzf custom functions from dotfiles
  };
  programs.bat = {
    enable = true;
    catppuccin.enable = true;
    extraPackages = with pkgs.bat-extras; [
      # batdiff # this or delta. batdiff is a bit lighter but delta is better supported
      batman
      batgrep
    ];
    config = {
      # default themes OR a {key} from themes (below)
      # NOTE: to refresh themes, run "bat cache --build"
      # theme = "catppuccin-macchiato";
    };
    # themes = {
    #   # NOTE: superseded by catppuccin.nix flake
    #   catppuccin-macchiato = {
    #     src = pkgs.fetchFromGitHub {
    #       owner = "catppuccin";
    #       repo = "bat";
    #       rev = "d3feec47b16a8e99eabb34cdfbaa115541d374fc";
    #       # for how to fetch this, see ./../../LEARNINGS.md
    #       hash = "sha256-s0CHTihXlBMCKmbBBb8dUhfgOOQu9PBCQ+uviy7o47w=";
    #     };
    #     file = "themes/Catppuccin Macchiato.tmTheme";
    #   };
    # };
  };
  # FIXME: annoying conflict in ~/.config/gh/config.yml
  programs.gh = {
    enable = true;
    settings = {
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
      # unneeded if it uses $EDITOR
      # editor = "nvim";
    };
    extensions = [
      pkgs-unstable.gh-notify
      pkgs-unstable.gh-f # interacively search
      pkgs-unstable.gh-s # search
      pkgs-unstable.gh-eco
      pkgs-unstable.gh-copilot
      # pkgs-unstable.gh-dash # below
    ];
  };
  programs.gh-dash = {
    enable = true;
    catppuccin.enable = true;
  };
  programs.lazygit = {
    enable = true;
    catppuccin.enable = true;
  };
  # superset of tldr + cheatsheets
  programs.navi = {
    enable = true;
    settings = {
      client.tealdeer = true;
    };
  };
  programs.thefuck = {
    enable = true;
    enableZshIntegration = true;
    enableInstantMode = false; # requires disabling zsh autocomplete
  };

  # NOTE: nap code snippets configurations; replace with home-manager when implemented
  home.activation.configureNapSnippets =
    lib.hm.dag.entryAfter [ "writeBoundary" ] # sh
      ''
        rm -rf $HOME/.config/nap
        ln -sf ${flakeVars.FLAKE_DOTS}/nap $HOME/.config/nap
      '';
  programs.zsh.sessionVariables = {
    NAP_HOME = "$HOME/.config/nap/snippets";
    NAP_CONFIG = "$HOME/.config/nap/config.yaml";
  };
}

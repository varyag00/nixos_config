{ pkgs, ... }:
{

  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html
  #
  # TODO Fell free to modify this file to fit your needs.
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    # neovim
    git
    just # use Justfile to simplify nix-darwin's commands
  ];
  environment.variables.EDITOR = "nvim";

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    masApps = {
      # TODO Feel free to add your favorite apps here.

      #Xcode = 497799835;
      # Wechat = 836500024;
      # NeteaseCloudMusic = 944848654;
      # QQ = 451108668;
      # WeCom = 1189898970;  # Wechat for Work
      # TecentMetting = 1484048379;
      # QQMusic = 595615424;
    };

    taps = [
      "homebrew/services"
      "nikitabobko/tap" # aerospace
      "FelixKratz/formulae" # sketchybar and borders (jankyborders); used with aerospace
    ];

    # `brew install`
    brews = [
      "wget" # download tool
      "curl" # no not install curl via nixpkgs, it's not working well on macOS!
      "aria2" # download tool
      "httpie" # http client

      "pngpaste" # paste images from clipboard to md docs
      "ollama"
      "screenresolution" # programmatically set screen resolution

      "syncthing"

      # "podman-desktop" # container runtime # NOTE: i'm using collima instead
      # "duti" # set default app for file types # NOTE: unused; i'm just using neovide as default app for code files

      # from FelixKratz/formulae tap; useful for aerospace
      # NOTE: run on startup using `brew services start {name}`
      "borders" # adds a border to the active window
    ];

    # `brew install --cask`
    casks =
      [
        # NOTE: corresponding dots are in shell/mac_dots.nix
        # the intention is to migrate everything to being managed by home-manager 

        "karabiner-elements"

        "maccy" # clipboard manager
        # TODO: add raycast plugins and settings to config flake
        "raycast" # (HotKey: alt/option + space)search, caculate and run scripts(with many plugins)

        "bitwarden" # NOTE: brew package doesn't support touchID

        # Development
        #"insomnia" # REST client
        #"wireshark" # network analyzer
        "visual-studio-code"
        "bruno" # http testing cli/gui; similar hurl bit with an included GUI

        # browser for the martian (n)vimer
        "qutebrowser"
        "brave-browser"

        "desktoppr" # set wallpaper programmatically

        # Services (run in background on startup)
        # NOTE: most of these should be made to run these as services via `brew services start {name}`
        ## TODO: run at startup via brew instead
        "aerospace" # i3-like twm
        "jordanbaird-ice" # statusbar management
        "stats" # beautiful system monitor; NOTE: enable via brew services start stats
      ]
      ++
      # work
      [
        "github"
        "citrix-workspace"
      ];
  };
}

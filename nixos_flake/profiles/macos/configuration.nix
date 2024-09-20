{ config, lib, pkgs, inputs, ... }:

{
  # NOTE: see options https://mynixos.com/search?q=nixpkgs%2Foption

  wsl.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/system/security/sshd.nix
      ../../modules/system/programs/helpers.nix
    ];

  # allow dynamically linked programs to be loaded
  programs.nix-ld = {
    enable = true;
    # libraries = with pkgs; [
    #   # Add any missing dynamic libraries for unpackaged programs
    #   # here, NOT in environment.systemPackages
    # ];
    package = inputs.nix-ld-rs.packages."${pkgs.system}".nix-ld-rs;
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Amsterdam";

  # make zsh the default shell
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];

  users.defaultUserShell = pkgs.zsh;
  users.users.dan.shell = pkgs.zsh;


  environment.systemPackages = with pkgs;
  [
    home-manager
    zsh
    wget
    gcc
    ripgrep
    git
    tlrc # tldr in rust

    # nvim lsp
    yaml-language-server
    unzip
    tree-sitter
    nodejs_21
    luajitPackages.luarocks-nix # lua package manager
    cargo # rust package manager

    # alejandra
    nixfmt-rfc-style
    # TODO: move these to user/shell/cli-apps.nix
    neovim
  ];

  programs.neovim = {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # SECTION: services

  # services.openssh = {
  #   enable = true;
  #   # require public key authentication for better security
  #   settings.PasswordAuthentication = false;
  #   settings.KbdInteractiveAuthentication = false;
  #   #settings.PermitRootLogin = "yes";
  # };
  # users.users."dan".openssh.authorizedKeys.keys = [
  #   # dan-wks-3080 windows key
  #   "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIdjUmRaJCKDBRZHI6VyKKOOdWD08Ezg5Aqa+u3cL8ZNdAzPudikv5x6RPemcjWg4Pj0s8nXsFl9UYJmDW7tgCdaf6m20aWu/0R3tGjOc+O+MfGnGkbdvH0gl9gm7OtGeywn1BO777SlmXnu788+69DLcXftjgf4za/AW3mP/LnPPp2TKgONi/+4nKQSC/20H0yAZib7u4cav4QBHTy2u7UvmDLHKPGfP4OwINVVub2LI+bzMrbTqs2LrZzG9JyfdNTojZh6lszubkVQ9cNojsWcmovn2iswruTgtjvzxeENEWHk6VdJUKr1bSDusIQ0ucDTuqbJqA80bP9l4m+GqSZfTMjNC+m/gljSW33oDmkiXgW5VZb6RZV3gktqngDT8ghfkFkHi3JfRtGy1THWEOskGz+fGQ5w9j9Q9tB9WBGqfMxE0u6P/65a+bnmypntGv649RpxD3nJ7e7FwPzy9Ekcoy7IZffDuoTvqbqjIcAfyHOT9iLFPg233KuYMxGi0= dgonz@dan-wks-3080"
  #   # note: ssh-copy-id will add user@your-machine after the public key
  #   # but we can remove the "@your-machine" part
  # ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dan = {
    isNormalUser = true;
    description = "Dan G";
    extraGroups = [ "wheel" "networkmanager" "vboxsf" ]; # Enable ‘sudo’ for the user.
     #packages = with pkgs; [
     #  firefox
     #  tree
     #];
  };

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}

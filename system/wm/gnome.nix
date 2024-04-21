{ pkgs, ... }:

{

  imports = 
    [ 
      ./dbus.nix
      ./fonts.nix
    ];

  # x11 config
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    xkbOptions = "caps:escape";
    excludePackages = [ pkgs.xterm ];
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    gedit
    epiphany
    geary
    evince
    gnome-characters
    totem
    tali
    iagno
    hitori
    atomix
    yelp
    gnome-contacts
    gnome-initial-setup
  ]);

  environment.systemPackages = with pkgs; [
    gnome.gnomeTweaks
  ];

  programs.dconf.enable = true;

  # gnome-keyring
  services.gnome = {
    gnome-keyring.enable = true;
  };

  # pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}

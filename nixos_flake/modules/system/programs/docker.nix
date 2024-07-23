{
  config,
  inputs,
  pkgs,
  userSettings,
  ...
}:

{
  # https://nixos.wiki/wiki/Docker
  virtualisation.docker.enable = true;
  # add user to docker group
  users.extraGroups.docker.members = [ userSettings.username ];

  environment.systemPackages = with pkgs; [ ];
}

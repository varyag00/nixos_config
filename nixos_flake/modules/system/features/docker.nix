{
  config,
  inputs,
  pkgs,
  flakeVars,
  ...
}:

{
  # https://nixos.wiki/wiki/Docker
  virtualisation.docker.enable = true;
  # add user to docker group
  users.extraGroups.docker.members = [ flakeVars.user.name ];

  environment.systemPackages = with pkgs; [ ];
}

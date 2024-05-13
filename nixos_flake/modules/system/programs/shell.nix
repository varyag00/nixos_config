{ config, inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs;
  [
    go-task
  ];
}

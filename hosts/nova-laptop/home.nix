# home-manager config for nova-laptop
{ pkgs, lib, ... }:

{
  imports = [ ../../home-manager/home.nix ];

  home = {
    packages = [ pkgs.watchmate ];
    stateVersion = lib.mkForce "23.05";
  };
}

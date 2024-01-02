# home-manager config for aspire
{ lib, pkgs, ... }:

{
  imports = [ ../../home-manager/home.nix ];

  home.stateVersion = lib.mkForce "23.05";
}

# home-manager config for aspire
{ pkgs, lib, ... }:

{
  imports = [ ../../home-manager/home.nix ];

  home.stateVersion = lib.mkForce "23.05";
}

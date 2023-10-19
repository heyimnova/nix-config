# User level config for aspire
{ pkgs, ... }:

{
  imports = [
    ../home.nix
  ];

  home.stateVersion = "23.05";
}

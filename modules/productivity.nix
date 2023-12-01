# home-manager productivity app config
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gimp
    onlyoffice-bin
    vscodium
  ];
}

# home-manager virtualisation config
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    quickemu
    quickgui
  ];
}

# User level virtualisation app config
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    quickemu
    quickgui
  ];
}

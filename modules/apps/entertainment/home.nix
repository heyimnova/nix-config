# User level entertainment app config
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fluent-reader
    freetube
    imaginer
  ];
}

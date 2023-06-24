{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fluent-reader
    freetube
    imaginer
  ];
}

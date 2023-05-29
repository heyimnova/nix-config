{ pkgs, ... }:

{
  home.packages = with pkgs; [
    watchmate
  ];
}

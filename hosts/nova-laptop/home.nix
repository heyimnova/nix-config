{ pkgs, ... }:

{
  home.packages = with pkgs; [
    itd
    siglo
  ];
}


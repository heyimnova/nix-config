{ pkgs, ... }:

{
  home.packages = with pkgs; [
    siglo
  ];
}


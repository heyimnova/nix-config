# User level programming app config
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    file
    git-filter-repo
    gitnuro
    nodejs
    poetry
    vscodium
  ];
}

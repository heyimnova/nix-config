{ pkgs, ... }:

{
  home.packages = with pkgs; [
    file
    git-filter-repo
    gitnuro
    nodejs
    nodePackages.npm
    poetry
    vscodium
  ];
}

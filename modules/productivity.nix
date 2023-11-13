# home-manager productivity app config
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gimp
    git-filter-repo
    gitnuro
    onlyoffice-bin
    texworks
    vscodium
  ];
}

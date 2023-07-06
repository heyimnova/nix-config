{ pkgs, ... }:

{
  home.packages = with pkgs; [
    birdtray
    bitwarden
    bleachbit
    brave
    cpu-x
    gimp
    helvum
    inkscape
    onlyoffice-bin
    protonmail-bridge
    qbittorrent
    spotify
    texworks
    thunderbird
    tor-browser-bundle-bin
  ];
}

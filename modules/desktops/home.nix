# User level general desktop app config
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    birdtray
    bitwarden
    bleachbit
    cpu-x
    distrobox
    gimp
    helvum
    inkscape
    logseq
    mission-center
    onlyoffice-bin
    protonmail-bridge
    qbittorrent
    spotify
    texworks
    thunderbird
    tor-browser-bundle-bin
  ];
}

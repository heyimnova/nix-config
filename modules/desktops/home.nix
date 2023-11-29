# Default home-manager desktop config
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    birdtray
    bitwarden
    bleachbit
    clamtk
    cpu-x
    distrobox
    helvum
    logseq
    mission-center
    protonmail-bridge
    qbittorrent
    spotify
    thunderbird
    tor-browser-bundle-bin
  ];
}

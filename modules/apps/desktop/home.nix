{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwarden
    bleachbit
    brave
    cpu-x
    helvum
    protonmail-bridge
    spotify
    thunderbird
    tor-browser-bundle-bin
  ];
}

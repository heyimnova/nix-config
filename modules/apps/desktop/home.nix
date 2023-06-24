{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwarden
    brave
    cpu-x
    helvum
    protonmail-bridge
    spotify
    thunderbird
    tor-browser-bundle-bin
  ];
}

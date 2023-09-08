# User level gaming app config
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bottles
    # TODO: See if I can select different packages depending on the installed DE
    cartridges
    grapejuice
    heroic
    prismlauncher
    protonup-qt
  ];
}

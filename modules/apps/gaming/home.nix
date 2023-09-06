# User level gaming app config
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bottles
    # TODO: See if I can select different packages depending on the installed DE
    cartridges
    grapejuice
    heroic
    (lutris.override {
      extraLibraries = pkgs: [
        # These libraries fix bugs with Battlefield 3 on Lutris
        libgpg-error
        jansson
      ];
    })
    prismlauncher
    protonup-qt
  ];
}

# User level gaming app config
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bottles
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

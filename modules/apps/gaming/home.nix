{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bottles
    grapejuice
    heroic
    (lutris.override {
      extraLibraries = pkgs: [
        libgpg-error
        jansson
      ];
    })
    prismlauncher
    protonup-qt
  ];
}

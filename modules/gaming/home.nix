# home-manager gaming config
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gamescope
    heroic
    prismlauncher
    protonup-qt

    (lutris.override {
      extraLibraries = pkgs: [
        libgpg-error
        jansson
        pango
        wine
      ];
    })
  ];
}

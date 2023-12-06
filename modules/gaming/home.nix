# home-manager gaming config
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gamescope
    heroic
    prismlauncher
    protonup-qt
    r2modman

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

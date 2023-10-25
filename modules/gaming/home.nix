# home-manager gaming config
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bottles
    prismlauncher
    protonup-qt

    (heroic.override {
      extraLibraries = pkgs: [
        libunwind
      ];
    })

    (lutris.override {
      extraLibraries = pkgs: [
        libgpg-error
        jansson
        wine
      ];
    })
  ];
}

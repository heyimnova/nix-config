# home-manager gaming module
{ lib, config, pkgs, umu, ... }:

let
  cfg = config.gaming;
in
{
  options.gaming.enable = lib.mkEnableOption "gaming apps";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bottles
      gamescope
      heroic
      prismlauncher
      protonup-qt
      r2modman
      vkbasalt

      (lutris.override {
        extraLibraries = pkgs: [
          libgpg-error
          jansson
          pango
          wine
        ];

        extraPkgs = pkgs: [
          wget

          (umu.packages.${pkgs.system}.umu.override {version = "${umu.shortRev}";})
        ];
      })
    ];
  };
}

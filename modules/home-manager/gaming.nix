# home-manager gaming module
{ lib, config, pkgs, ... }:

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

      (lutris.override {
        extraLibraries = pkgs: [
          libgpg-error
          jansson
          pango
          wine
        ];

        extraPkgs = pkgs: [
          wget
        ];
      })
    ];
  };
}

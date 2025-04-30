# home-manager gaming module
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.gaming;
in {
  options.modules.gaming.enable = lib.mkEnableOption "gaming apps";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bottles
      gamescope
      heroic
      prismlauncher
      protonup-qt
      r2modman
      torzu
      vkbasalt

      (lutris.override {
        extraLibraries = pkgs: [
          libgpg-error
          jansson
          pango
          wine
        ];

        extraPkgs = pkgs: [
          umu-launcher
          wget
        ];
      })
    ];
  };
}

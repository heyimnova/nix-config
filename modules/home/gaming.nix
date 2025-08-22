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
      gamescope
      heroic
      prismlauncher
      protonplus
      r2modman
      vkbasalt

      (bottles.override {
        removeWarningPopup = true;
      })

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

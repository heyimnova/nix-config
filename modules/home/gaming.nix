# home-manager gaming module
{
  lib,
  config,
  pkgs,
  inputs,
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

          (inputs.umu.packages.${pkgs.system}.umu.override {version = "${inputs.umu.shortRev}";})
        ];
      })
    ];
  };
}

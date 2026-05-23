# Optional app bundles for home-manager
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.apps;
in {
  options.modules.apps = {
    productivity = lib.mkEnableOption "productivity apps";
    social = lib.mkEnableOption "social apps";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.productivity {
      programs.zed-editor = {
        enable = true;

        extraPackages = with pkgs; [
          # Nix support
          alejandra
          nil
          nixd
        ];
      };

      home.packages = with pkgs; [
        clapgrep
        gimp3
        gitnuro
        godot_4
      ];
    })

    (lib.mkIf cfg.social {
      programs.vesktop.enable = true;

      home.packages = with pkgs; [
        fluent-reader
        freetube
        signal-desktop
        stoat-desktop
      ];
    })
  ];
}

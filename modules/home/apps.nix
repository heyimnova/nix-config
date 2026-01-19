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
      home.packages = with pkgs; [
        clapgrep
        devtoolbox
        gimp3
        gitnuro
        godot_4
        onlyoffice-desktopeditors
      ];
    })

    (lib.mkIf cfg.social {
      programs.vesktop.enable = true;

      home.packages = with pkgs; [
        fluent-reader
        freetube
        revolt-desktop
        signal-desktop
      ];
    })
  ];
}

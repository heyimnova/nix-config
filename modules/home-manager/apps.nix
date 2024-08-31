{ lib, config, pkgs, ... }:

let
  cfg = config.apps;
in
{
  options.apps = {
    productivity = lib.mkEnableOption "productivity apps";
    social = lib.mkEnableOption "social apps";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.productivity {
      home.packages = with pkgs; [
        gimp
        gitnuro
        godot_4
        onlyoffice-bin
      ];
    })

    (lib.mkIf cfg.social {
      home.packages = with pkgs; [
        fluent-reader
        freetube
        revolt-desktop
        signal-desktop
        vesktop
      ];
    })
  ];
}
